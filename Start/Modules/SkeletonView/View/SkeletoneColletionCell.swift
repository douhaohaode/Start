//
//  SkeletoneColletionCell.swift
//  Start
//
//  Created by pactera on 2020/12/8.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import SkeletonView
import RxSwift

class SkeletoneColletionCell: YMTBaseColletionCell {
    
    var bag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    override func setupLayout(){
        
        backgroundColor = .white
        contentView.layer.cornerRadius = 9.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        contentView.layer.masksToBounds = true
        iconImage.isSkeletonable = true
        titleLabel.isSkeletonable = true
        subtitle.isSkeletonable = true
        shop.isSkeletonable = true
        contentLabel.isSkeletonable = true
        contentImage.isSkeletonable = true
        productImage.isSkeletonable = true
        productTitleLabel.isSkeletonable = true
        productSubtitle.isSkeletonable = true
        productPrice.isSkeletonable = true
        readLabel.isSkeletonable = true
        productImage.layer.cornerRadius = 9.0
        productImage.layer.masksToBounds = true
        contentImage.layer.cornerRadius = 9.0
        contentImage.layer.masksToBounds = true
        contentView.addSubview(iconImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitle)
        contentView.addSubview(shop)
        contentView.addSubview(contentLabel)
        contentView.addSubview(contentImage)
        contentView.addSubview(productImage)
        contentView.addSubview(productTitleLabel)
        contentView.addSubview(productSubtitle)
        contentView.addSubview(productPrice)
        contentView.addSubview(readLabel)
        isSkeletonable = true
        productSubtitle.text = "期間限定購入"
        productTitleLabel.text = "KANUINブランドチャーリーズウォッチオスメカニカル"
        productPrice.text = "¥24999"
        readLabel.text = "読んだ（20299）"
        subtitle.text = "これは面白いお店です"
        
        titleLabel.textAlignment = .left
        titleLabel.font =  wfont19
        iconImage.layer.cornerRadius = 25
        iconImage.layer.masksToBounds = true
        subtitle.textAlignment = .left
        
        shop.setTitleColor(.white, for: .normal)
        shop.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        shop.setTitle("店に", for: .normal)
        contentLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        iconImage.snp.makeConstraints { (make) in
            make.size.equalTo(50)
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImage.snp.right).offset(15)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(SCREEN_WIDTH / 2 ).priority(.high)
            make.height.equalTo(20)
        }
        subtitle.snp.makeConstraints { (make) in
            make.left.equalTo(iconImage.snp.right).offset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.width.equalTo(SCREEN_WIDTH / 2 )
            make.height.equalTo(20)
        }
        shop.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImage.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(40)
            make.width.equalTo(SCREEN_WIDTH  - 100)
            make.height.equalTo(90)
        }
        contentImage.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(180)
        }
        productImage.snp.makeConstraints { (make) in
            make.top.equalTo(contentImage.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        productTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(productImage.snp.right).offset(10)
            make.top.equalTo(contentImage.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        productSubtitle.snp.makeConstraints { (make) in
            make.left.equalTo(iconImage.snp.right).offset(10)
            make.top.equalTo(productTitleLabel.snp.bottom).offset(3)
            make.width.equalTo(SCREEN_WIDTH / 4)
            make.height.equalTo(20)
        }
        productPrice.snp.makeConstraints { (make) in
            make.left.equalTo(productSubtitle.snp.right).offset(5)
            make.top.equalTo(productTitleLabel.snp.bottom).offset(3)
            make.width.equalTo(SCREEN_WIDTH / 4)
            make.height.equalTo(20)
        }
        readLabel.snp.makeConstraints { (make) in
            make.top.equalTo(productImage.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
            make.width.equalTo(SCREEN_WIDTH / 2 )
        }
        
    }
    
}
