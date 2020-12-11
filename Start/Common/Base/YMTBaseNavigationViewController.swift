//
//  YMTNavigationViewController.swift
//  Start
//
//  Created by pactera on 2020/10/23.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit

class YMTBaseNavigationViewController: UINavigationController ,UIGestureRecognizerDelegate {
    
    open var tabBarSelectedIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white;
    }
    
    func setupTabBarChaildVcNavColor(BackgroundColor : UIColor ,titleColor : UIColor){
        
        navigationBar.tintColor = BackgroundColor;
        let dic = [NSAttributedString.Key.foregroundColor :titleColor,
                   NSAttributedString.Key.font : wfont19]
        navigationBar.titleTextAttributes = dic as [NSAttributedString.Key : Any]
    }
    
    /**
     添加 pop全屏手势
     self.navigationController.interactivePopGestureRecognizer.enabled = YES;
     系统默认可以测滑，但是由于自定义返回按钮 导致失效 所以需要单独处理一下测滑放回方式。
     创建一个全屏手势覆盖系统的方法
     */
    
    func popPanGesture(){
        let pan = UIPanGestureRecognizer(target: self.interactivePopGestureRecognizer!.delegate, action: (Selector(("handleNavigationTransition:"))))
            pan.delegate = self;
            view.addGestureRecognizer(pan)
            self.interactivePopGestureRecognizer?.isEnabled = false;
    }

    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        //如果控制器与手势冲突可以单独处理
        //if ((children.last?.isKind(of: HomepageViewController.self)) != nil){
        // return false;
        //  }
        return children.count != 1 ;
    }
    
    /**
     根据跟视图的数量，是否可用使用手势返回
     */
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
       
        if viewControllers.count > 0{
            viewController.hidesBottomBarWhenPushed = true;
            viewController.navigationController?.navigationBar.subviews.first?.alpha = 1;
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Back", comment: ""), style:.plain , target: self, action: #selector(baclk))
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func baclk(){
        popViewController(animated: true)
    }
    
}
