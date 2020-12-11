//
//  YMTNavBarButton.swift
//  Start
//
//  Created by pactera on 2020/10/26.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit

class YMTNavBarButton: UIView {
    
    open  lazy  var BarButton  = {() -> UIButton  in
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .clear
        btn.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), for: .normal)
        btn.setTitleColor(UIColor.gray, for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 17)
        btn.frame  = CGRect(x: 0, y: 0, width: self.frame.size.width , height:self.frame.size.height)
        return btn
    }()
    
    open  lazy  var BarLabel  = {() -> UILabel  in
        let label = UILabel()
        label.text = "30 C"
        label.textAlignment = .center
        label.font = wfont11
        label.frame = CGRect(x: 0, y: self.frame.size.height/3*2, width:self.frame.size.width , height: self.frame.size.height/3)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addSubview(BarButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
