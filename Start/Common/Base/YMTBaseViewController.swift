//
//  YMTBaseViewController.swift
//  Start
//
//  Created by pactera on 2020/10/23.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift

#if os(iOS)
import UIKit
typealias YMTOSViewController = UIViewController
#elseif os(macOS)
import Cocoa
typealias YMTOSViewController = NSViewController
#endif

class YMTBaseViewController: YMTOSViewController {
    
    var disposeBag = DisposeBag()
    
    public lazy var leftNavBarButton : YMTNavBarButton = YMTNavBarButton(frame: CGRect(x: 0, y: 0, width: 45, height: 35))
    
    public lazy var rightNavBarButton : YMTNavBarButton = YMTNavBarButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
    
    public lazy   var custmoSearchBarView   = {() -> UIView  in
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 160, height: 30))
        let bar = UISearchBar(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 160, height: 30))
        bar.placeholder = NSLocalizedString("SearchPlaceholder", comment: "")
        if #available(iOS 13.0, *) {
               bar.searchTextField.backgroundColor = SerachColor
        }else{
            let testfield :UITextField = bar.value(forKey: "searchField") as! UITextField
            testfield.backgroundColor = SerachColor
        }
        view.addSubview(bar)
        return view
    }()
    
    public func buildNavigationView(){
        leftNavBarButton.BarButton.setTitle("东京", for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView:leftNavBarButton)
        rightNavBarButton.BarButton.setBackgroundImage(UIImage(named: "huanxingtu"), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView:rightNavBarButton)
        navigationItem.titleView = custmoSearchBarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
