//
//  YMTBaseColletionCell.swift
//  Start
//
//  Created by pactera on 2020/11/5.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit

class YMTBaseColletionCell: UICollectionViewCell {
    
    open lazy var contentLabel = {()->UILabel in
        let lab = UILabel()
        lab.numberOfLines = 0
        return lab
    }()
    open  lazy var iconImage = { ()-> UIImageView in
        let image = UIImageView()
        return image
    }()
    open  lazy var titleLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .center
        return lab
    }()
    open   lazy var priceLabel = {()->UILabel in
        let lab = UILabel()
        return lab
    }()
    open  lazy var paymentLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        return lab
    }()
    open  lazy var activitiesLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .center
        return lab
    }()
    open  lazy var backgroudView = {()->UIView in
        let view = UIView()
        return view
    }()
    open  lazy var subtitle = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return lab
    }()
    open lazy var contentImage = { ()-> UIImageView in
        let image = UIImageView()
        return image
    }()
    
    open  lazy var productImage = { ()-> UIImageView in
        let image = UIImageView()
        return image
    }()
    
    open   lazy var productTitleLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.numberOfLines = 0
        lab.font = wfont17
        return lab
    }()
    open   lazy var productSubtitle = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        lab.font = wfont17
        return lab
    }()
    open   lazy var productPrice = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        //lab.numberOfLines = 0
        lab.font = wfont17
        return lab
    }()
    
    open   lazy var readLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        //lab.numberOfLines = 0
        lab.font = UIFont.systemFont(ofSize: 13)
        return lab
    }()
    
    open lazy var buttonBar  = {() -> UIButton in
        let btn = UIButton()
        btn.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0);
        btn.setTitleColor(UIColor.init(red: 1/255, green: 1/255, blue: 1/255, alpha: 1.0), for: .normal)
        btn.titleLabel?.font = wfont13
        btn.setTitleColor(UIColor.gray, for: .highlighted)
        btn.layer.borderWidth = 1
        btn.layer.borderColor =  UIColor.init(red: 105/255, green: 232/255, blue: 253/255, alpha: 1.0).cgColor
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()
    
    open lazy var buttonBar1  = {() -> UIButton in
        let btn = UIButton()
        btn.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0);
        btn.setTitleColor(UIColor.init(red: 1/255, green: 1/255, blue: 1/255, alpha: 1.0), for: .normal)
        btn.titleLabel?.font = wfont13
        btn.setTitleColor(UIColor.gray, for: .highlighted)
        btn.layer.borderWidth = 1
        btn.layer.borderColor =  UIColor.init(red: 105/255, green: 232/255, blue: 253/255, alpha: 1.0).cgColor
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()
    open lazy var shop  = {() -> UIButton in
        let btn = UIButton()
        btn.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0);
        btn.setTitleColor(UIColor.init(red: 1/255, green: 1/255, blue: 1/255, alpha: 1.0), for: .normal)
        btn.titleLabel?.font = wfont15
        btn.setTitleColor(UIColor.gray, for: .highlighted)
        btn.layer.borderWidth = 1
        btn.layer.borderColor =  UIColor.init(red: 105/255, green: 232/255, blue: 253/255, alpha: 1.0).cgColor
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupLayout() {}
}
