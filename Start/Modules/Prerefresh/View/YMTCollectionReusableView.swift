//
//  YMTCollectionReusableView.swift
//  Start
//
//  Created by pactera on 2020/11/5.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import SkeletonView

class YMTCollectionReusableView: UICollectionReusableView{
    
    lazy var dateLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .center
        lab.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lab.numberOfLines = 0
        lab.font = wfont15
        return lab
    }()
    lazy var contentLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lab.numberOfLines = 0
        lab.font = wfont17
        return lab
    }()
    lazy var iconImage = { ()-> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "placeholder")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ThemeColor
        self.addSubview(iconImage)
        self.addSubview(contentLabel)
        self.addSubview(dateLabel)
        
        iconImage.snp.makeConstraints { (make) in
            make.size.equalTo(30)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        contentLabel.snp.makeConstraints { (make) in
            make.height.equalTo(25)
            make.width.equalTo(SCREEN_WIDTH - 70)
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(iconImage.snp.right).offset(15)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(contentLabel.snp.bottom).offset(3)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
}

class YMTDetalisCollectionReusableView: UICollectionReusableView{
    
    
    
    
    lazy var titleContent = {()->UILabel in
        let text = UILabel()
        text.textAlignment = .center
        text.textColor = UIColor.black
        text.font = wfont19
        text.text = "更多 , 更多"
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleContent.backgroundColor = .white
        titleContent.isSkeletonable = true
        self.addSubview(titleContent)
        
        isSkeletonable = true

        titleContent.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
}

