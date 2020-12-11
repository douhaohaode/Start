//
//  YMTCollectionCell.swift
//  Start
//
//  Created by pactera on 2020/10/23.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift
import SkeletonView

class YMTCollectionCell: YMTBaseColletionCell {
    
    override func setupLayout(){
        
        contentLabel.textAlignment = .center
        contentLabel.textColor = #colorLiteral(red: 0.3884391192, green: 0.3884391192, blue: 0.3884391192, alpha: 1)
        contentLabel.numberOfLines = 0
        contentLabel.font = wfont13
        iconImage.image = UIImage(named: "news")
        backgroundColor = .white
        addSubview(iconImage)
        addSubview(contentLabel)
        
        iconImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(5)
            make.height.width.equalTo(50)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImage.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}

class YMTCollectionTitleCell: YMTBaseColletionCell {
    
    override func setupLayout(){
        
        contentView.layer.cornerRadius = 9.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        contentView.layer.masksToBounds = true
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        titleLabel.numberOfLines = 0
        titleLabel.font = wfont17
        titleLabel.text = "天美厚底チェルシーブーツとベルベットネットレッド"
        
        priceLabel.textAlignment = .left
        priceLabel.textColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        priceLabel.numberOfLines = 0
        priceLabel.text = "¥848.471"
        priceLabel.font = wfont19
        
        paymentLabel.textAlignment = .left
        paymentLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        paymentLabel.numberOfLines = 0
        paymentLabel.font = UIFont.systemFont(ofSize: 13)
        paymentLabel.text = "2110支払い"
        
        activitiesLabel.textAlignment = .center
        activitiesLabel.textColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        activitiesLabel.font = UIFont.systemFont(ofSize: 13)
        activitiesLabel.layer.borderColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1).cgColor
        activitiesLabel.layer.borderWidth = 1;
        activitiesLabel.text = "ゴールドコイン交換"
        
        iconImage.image = UIImage(named: "aaaa")
        backgroundColor = .white
        contentView.addSubview(iconImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(activitiesLabel)
        contentView.addSubview(paymentLabel)
        
        
        iconImage.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(0)
            make.height.equalTo(frame.size.height/5*3)
            make.width.equalTo(frame.size.width)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImage.snp.bottom).offset(3)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(40)
            make.width.equalTo(frame.size.width - 20)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(0)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(frame.size.width/3)
            make.height.equalTo(25)
        }
        paymentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(0)
            make.left.equalTo(priceLabel.snp.right).offset(5)
            make.width.equalTo(frame.size.width / 2)
            make.height.equalTo(25)
        }
        activitiesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(frame.size.width/2)
            make.height.equalTo(25)
        }
    }
}

class YMTDetalisCollectionTitleCell: YMTBaseColletionCell {
    
    lazy var shopping  = {() -> UIButton in
        let btn = UIButton()
        btn.setTitle("加入购物车", for: .normal)
        btn.backgroundColor = UIColor(red: 228/255, green: 79/255, blue: 83/255, alpha: 1.0);
        btn.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), for: .normal)
        btn.titleLabel?.font = wfont17
        btn.setTitleColor(UIColor.gray, for: .highlighted)
        btn.layer.borderWidth = 1
        btn.layer.borderColor =  UIColor.init(red: 105/255, green: 232/255, blue: 253/255, alpha: 1.0).cgColor
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()
    lazy var buy  = {() -> UIButton in
        let btn = UIButton()
        btn.setTitle("立即购买", for: .normal)
        btn.backgroundColor = UIColor(red: 242/255, green: 46/255, blue: 53/255, alpha: 1.0);
        btn.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), for: .normal)
        btn.titleLabel?.font = wfont17
        btn.layer.borderWidth = 1
        btn.layer.borderColor =  UIColor.init(red: 105/255, green: 232/255, blue: 253/255, alpha: 1.0).cgColor
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()
    
    override func setupLayout(){
        backgroundColor = .white
        
        priceLabel.textAlignment = .left
        priceLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        priceLabel.numberOfLines = 0
        priceLabel.text = "¥848.471"
        priceLabel.font = wfont19
        
        paymentLabel.textAlignment = .left
        paymentLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        paymentLabel.numberOfLines = 0
        paymentLabel.text = "2110支払い"
        paymentLabel.font = wfont17
        
        activitiesLabel.textAlignment = .center
        activitiesLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        activitiesLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        activitiesLabel.font = wfont19
        activitiesLabel.layer.cornerRadius = 8
        activitiesLabel.clipsToBounds = true
        activitiesLabel.text = "双11"
        iconImage.image = UIImage(named: "aaaa")
        
        backgroudView.layer.cornerRadius = 2.0
        backgroudView.layer.borderWidth = 1.0
        backgroudView.layer.borderColor =  UIColor.white.cgColor
        backgroudView.layer.masksToBounds = true
        
        contentView.addSubview(backgroudView)
        backgroudView.addSubview(iconImage)
        backgroudView.addSubview(priceLabel)
        backgroudView.addSubview(activitiesLabel)
        backgroudView.addSubview(paymentLabel)
        backgroudView.addSubview(shopping)
        backgroudView.addSubview(buy)
        
        backgroudView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        
        iconImage.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(0)
            make.height.equalTo(frame.size.height/4*3)
            make.width.equalTo(frame.size.width - 40)
        }
        activitiesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImage.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(activitiesLabel.snp.bottom).offset(0)
            make.left.equalTo(activitiesLabel.snp.right).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        paymentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(activitiesLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(frame.size.width / 2)
            make.height.equalTo(25)
        }
        shopping.snp.makeConstraints { (make) in
            make.bottom.equalTo(paymentLabel.snp.bottom).offset(0)
            make.left.equalTo(priceLabel.snp.right).offset(0)
            make.height.equalTo(45)
        }
        buy.snp.makeConstraints { (make) in
            make.bottom.equalTo(paymentLabel.snp.bottom).offset(0)
            make.left.equalTo(shopping.snp.right).offset(3)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(shopping.snp.width).offset(0)
            make.height.equalTo(45)
        }
    }
}

class YMTTaobaoPhotoCollectionCell: YMTBaseColletionCell {
    
    override func setupLayout(){
        iconImage.image = UIImage(named: "news")
        backgroundColor = .white
        addSubview(iconImage)
        iconImage.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview().offset(0)
        }
    }
}

class YMTTaobaoTitleCollectionCell: YMTBaseColletionCell {
    
    var bag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    override func setupLayout(){
        
        iconImage.isSkeletonable = true
        contentLabel.isSkeletonable = true
        iconImage.layer.cornerRadius = (frame.size.width - 20)/2
        iconImage.layer.borderWidth = 1.0
        iconImage.layer.borderColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        iconImage.layer.masksToBounds = true
        backgroundColor = .white
        contentView.addSubview(iconImage)
        contentView.addSubview(contentLabel)
        contentLabel.textAlignment = .center
        isSkeletonable = true
        iconImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(frame.size.width - 20)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImage.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(0)
        }
    }
}

private let dotImage = UIImage(named: "pageControlDot")
private let dotSelectImage = UIImage(named: "pageControlCurrentDot")

private let images = ["empty-image"]

class YMTautoScrollViewCell: UICollectionViewCell {
    
    open lazy var autoScrollView: LTAutoScrollView = {
        let layout = LTDotLayout(dotWidth: 37/3.0, dotHeight: 19/3.0, dotMargin: 8, dotImage: dotImage, dotSelectImage: dotSelectImage)
        let autoScrollView = LTAutoScrollView(frame: CGRect(x: 10, y: 15, width: self.contentView.bounds.width-20, height: 200), dotLayout: layout)
        autoScrollView.backgroundColor = .white
        autoScrollView.layer.cornerRadius = 9
        autoScrollView.layer.masksToBounds = true
        autoScrollView.glt_timeInterval = 1.5
        autoScrollView.scrollDirection = .horizontal
        //autoScrollView.images = images
        //加载图片，内部不依赖任何图片加载框架
        autoScrollView.imageHandle = {(imageView, imageName) in
            //加载本地图片（根据传入的images数组来决定加载方式）
            // imageView.image = UIImage(named: imageName)
            //加载网络图片（根据传入的images数组来决定加载方式）
           // imageView.kf.setImage(with: URL(string: imageName))
            imageView.kf.setImage(with: URL(string: imageName), placeholder: #imageLiteral(resourceName: "empty-image"), options: [.transition(.fade(1))])
            
            imageView.contentMode = .scaleAspectFill
        }
        autoScrollView.isDisableScrollGesture = false
        autoScrollView.gltPageControlHeight = 20;
        autoScrollView.dotDirection = .default
        /*点击事件*/
        autoScrollView.didSelectItemHandle = { index in
        }
        /*自动滚动到当前索引事件*/
        autoScrollView.autoDidSelectItemHandle = { index in
        }
        /*PageControl点击事件*/
        autoScrollView.pageControlDidSelectIndexHandle = { index in
        }
        return autoScrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = CellColor
        self.contentView.addSubview(autoScrollView)
        
    }
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
}
