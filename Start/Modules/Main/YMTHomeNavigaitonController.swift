//
//  YMTHomeNavigaitonController.swift
//  Start
//
//  Created by pactera on 2020/10/23.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit

class YMTHomeNavigaitonController: YMTBaseNavigationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let image  = imageFromColor(color: UIColor.init(red: 0/255, green: 175/255, blue: 158/255, alpha: 1.0), viewSize: CGSize(width: Int(self.navigationBar.frame.size.width), height: kTopHeight))
        self.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationBar.shadowImage = UIImage()
        
      setupTabBarChaildVcNavColor(BackgroundColor: UIColor.white, titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        popPanGesture()
      }

    func imageFromColor(color: UIColor, viewSize: CGSize) -> UIImage{
        
         let rect: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
         UIGraphicsBeginImageContext(rect.size)
         let context: CGContext = UIGraphicsGetCurrentContext()!
         context.setFillColor(color.cgColor)
         context.fill(rect)
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsGetCurrentContext()
         return image!
    }
}
