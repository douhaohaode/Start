
//
//  File.swift
//  Start
//
//  Created by pactera on 2020/11/4.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    // 单例
       static let shared = CoreDataManager()
       
        var dataArray: [AppInfo] = [AppInfo]()
    
        var FavoritesArray : [Favorites] = [Favorites]()
    
       
       // 拿到AppDelegate中创建好了的NSManagedObjectContext
       lazy var context: NSManagedObjectContext = {
           let context = ((UIApplication.shared.delegate) as! AppDelegate).context
           return context
       }()
       
       // 更新数据
       private func saveContext() {
           do {
               try context.save()
           } catch {
               let nserror = error as NSError
               fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
           }
       }
    
        //增加  收藏夹 总表数据
//    func saveFavorites(favorites : Favorites) {
//        
//        let Info = NSEntityDescription.insertNewObject(forEntityName: "StartData", into: context) as! Favorites
//
//        
//    }
    
    //增加收藏夹
    func saverFavorites(title:String , quantity:Int , createDate: Date , editDate :Date){
        
        let Info = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: context) as! Favorites
        Info.title = title
        Info.quantity = Int64(quantity)
        Info.createDate = createDate
        Info.editDate = editDate
        saveContext()
      }
    
    //增加条目
    func saverFavoritesResult(title: String ,tid :Int , ImageData:Data){
        
        let info = NSEntityDescription.insertNewObject(forEntityName: "FavoritesResult", into: context) as! FavoritesResult
        info.id = Int16(tid)
        info.imageData = ImageData
        info.title = String(format: "第%ld张",tid)
        saveContext()
    }
    
    //获取收藏夹信息
    func getAllFavorites() ->[Favorites]{
        let fetchRequest: NSFetchRequest = Favorites.fetchRequest()
             do {
                 let result = try context.fetch(fetchRequest)
                 return result
             } catch {
                 fatalError();
             }
    }
  
    //获取收藏夹结果信息
    func getAllFavoritesResult() ->[FavoritesResult]{
        let fetchRequest: NSFetchRequest = FavoritesResult.fetchRequest()
             do {
                 let result = try context.fetch(fetchRequest)
                 return result
             } catch {
                 fatalError();
             }
    }
    
    
    
    // 增加版本信息数据
       func savePersonWith(appInfo: AppInfo) {
        
           let Info = NSEntityDescription.insertNewObject(forEntityName: "StartData", into: context) as! AppInfo
            Info.lastVersion = appInfo.lastVersion
            Info.currentVersion = appInfo.currentVersion
            Info.enterbackgroundTime = appInfo.enterbackgroundTime
            //person.title = title
            //person.id = id
            //person.content = "内容"
            //person.imageData = "aaassdfa".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
           saveContext()
       }
       
       // 根据姓名获取数据
       func getPersonWith(title: String) -> [AppInfo] {
           let fetchRequest: NSFetchRequest = AppInfo.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "name == %@", title)
           do {
               let result: [AppInfo] = try context.fetch(fetchRequest)
               return result
           } catch {
               fatalError();
           }
       }
       
       // 获取所有数据
       func getAllPerson() -> [AppInfo] {
           let fetchRequest: NSFetchRequest = AppInfo.fetchRequest()
           do {
               let result = try context.fetch(fetchRequest)
               return result
           } catch {
               fatalError();
           }
       }
       
       // 根据姓名修改数据
       func changePersonWith(title: String, newTitle: String, newId: Int16) {
           let fetchRequest: NSFetchRequest = AppInfo.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "title == %@", title)
           do {
               let result = try context.fetch(fetchRequest)
               for  Info in result {
               // Info.title = title
//                   person.id = newId
//                   person.title = newTitle
               }
           } catch {
               fatalError();
           }
           saveContext()
       }
       
       // 根据姓名删除数据
       func deleteWith(title: String) {
           let fetchRequest: NSFetchRequest = AppInfo.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "title == %@", title)
           do {
               let result = try context.fetch(fetchRequest)
               for Info in result {
                   context.delete(Info)
               }
           } catch {
               fatalError();
           }
           saveContext()
       }
       
       // 删除所有数据
       func deleteAllPerson() {
           let result = getAllPerson()
           for Info in result {
               context.delete(Info)
           }
           saveContext()
       }
}
