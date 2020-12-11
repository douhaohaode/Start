//
//  YMTBaseTabBarController.swift
//  Start
//
//  Created by pactera on 2020/10/23.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit

struct TabBarModel {
    
    var navContorller : YMTBaseNavigationViewController
    
    var titleName  : String
    
    var imageName  : String
    
    var selectName : String
}

class YMTBaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false

    }
    
    func setChilds(controllers : Array<TabBarModel>){
        
        for i in 0..<controllers.count{
            let model = controllers[i]
            setChildsController(titles: model.titleName, imageNames: model.imageName, selectImageName: model.selectName, index: i ,navController: model.navContorller)
        }
    }
    
    func setChildsController(titles:String,imageNames:String,selectImageName:String ,index:Int,navController:YMTBaseNavigationViewController){
        
        navController.title = titles
        navController.tabBarItem.image = UIImage(named: imageNames)?.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = UIImage(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        navController.tabBarSelectedIndex  = index
        self.addChild(navController)
    }
    
}
