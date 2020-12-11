//
//  YMTExtensions.swift
//  Start
//
//  Created by pactera on 2020/11/4.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit

extension UIView {
    /**
     圆角的大小：corderSize，
     自动布局下切记一定设置imageSize
     */
    func cornerSets(corderSize: CGFloat, viewSize: CGSize) {
        bounds = CGRect.init(origin: CGPoint.zero, size: viewSize)
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize.init(width: 20, height: 5))
        let maskLayer = CAShapeLayer.init()
        maskLayer.path = maskPath.cgPath;
        maskLayer.frame = bounds
        layer.mask = maskLayer
    }
}
