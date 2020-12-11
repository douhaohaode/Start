//
//  AppDelegate.swift
//  Start
//
//  Created by pactera on 2020/12/11.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit

import CoreData

//import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            window = UIWindow.init(frame: UIScreen.main.bounds)
            window?.rootViewController = YMTHomePageTabBarController()
            loadPage()
            window?.makeKeyAndVisible()
        return true
    }
    
    func loadPage(){
        let  lastVersion = Preferences[.lastVersion]
        let  appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        //用户第一次使用 或者 用户版本升级
        if   lastVersion == "" ||  lastVersion != appVersion{
            let imageGifArray = ["page1Image@3x.png","page2Image@3x.png","page3Image@3x.png"]
                 let guideView = GuidePageView.init(images: imageGifArray, loginRegistCompletion: {
                     print("Lgoin")
                 }){
                     print("Look")
                 }
                guideView.isSlipIntoHomeView = true;
                window?.rootViewController!.view.addSubview(guideView)
        }else{
           //用户不是第一次启动
             loadAdvertisement()
        }
          Preferences[.lastVersion] = appVersion
          Preferences[.currentVersion] = appVersion
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        saveEnterbackgroundTime()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        let  enterbackgroundTime =  Preferences[.enterbackgroundTime]
               let  time = UInt64(Date.init(timeIntervalSinceNow: 0).timeIntervalSince1970)
               if (time - UInt64(enterbackgroundTime)) / 60 > 5{
                  loadAdvertisement()
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func saveEnterbackgroundTime(){
        let  timep = UInt64(Date.init(timeIntervalSinceNow: 0).timeIntervalSince1970)
              print(timep)
              Preferences[.enterbackgroundTime] = Double(timep)
    }

    func loadAdvertisement(){
         let adImageGifPath = Bundle.main.path(forResource: "Advertisement", ofType: "gif") ?? ""
         let _ = AdvertisementView(adUrl: adImageGifPath, isIgnoreCache: false, placeholderImage: nil, completion: { (isGotoDetailView) in
               print(isGotoDetailView)
           })
     }
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "YamotoData", withExtension: "momd")
        let managedObjectModel = NSManagedObjectModel.init(contentsOf: modelURL!)
        return managedObjectModel!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator.init(managedObjectModel: managedObjectModel)
        let sqliteURL = documentDir.appendingPathComponent("CoreData.sqlite")
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        var failureReason = "创建NSPersistentStoreCoordinator时出现错误"
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: sqliteURL, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: Any]()
            dict[NSLocalizedDescriptionKey] = "初始化NSPersistentStoreCoordinator失败" as Any?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as Any?
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 6666, userInfo: dict)
            print("未解决的错误： \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return persistentStoreCoordinator
    }()
    
    
    lazy var context: NSManagedObjectContext = {
         let context = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
         context.persistentStoreCoordinator = persistentStoreCoordinator
         return context
     }()
     
     lazy var documentDir: URL = {
         let documentDir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
         return documentDir!
     }()

}
