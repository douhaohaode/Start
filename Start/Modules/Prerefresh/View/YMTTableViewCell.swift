//
//  YMTHomePageCell.swift
//  Start
//
//  Created by pactera on 2020/10/23.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import RxDataSources
import SkeletonView

class YMTHomePageCell: UITableViewCell {
    
    lazy var titleLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .center
        lab.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lab.numberOfLines = 0
        lab.font = wfont13
        return lab
    }()
    lazy var contentLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lab.numberOfLines = 0
        lab.font = wfont15
        return lab
    }()
    lazy var iconImage = { ()-> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "news")
        return image
    }()
    func baseTableViewCell(tb tableView: UITableView ,RID ReuseID: String) -> YMTHomePageCell {
        var cell  = tableView.dequeueReusableCell(withIdentifier: ReuseID) as? YMTHomePageCell
        if cell == nil {
            cell = YMTHomePageCell.init(style: .value1, reuseIdentifier: ReuseID)
        }
        return cell!;
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none;
        if reuseIdentifier == "NewsCell" {
            self.contentView.addSubview(iconImage)
            self.contentView.addSubview(contentLabel)
            self.contentView.addSubview(titleLabel)
            
            iconImage.snp.makeConstraints { (make) in
                make.size.equalTo(30)
                make.left.top.equalToSuperview().offset(20)
            }
            
            contentLabel.snp.makeConstraints { (make) in
                make.height.equalTo(25)
                make.width.equalTo(SCREEN_WIDTH - 70)
                make.top.equalToSuperview().offset(8)
                make.left.equalTo(iconImage.snp.right).offset(15)
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.width.equalTo(100)
                make.right.equalToSuperview().offset(-20)
                make.top.equalTo(contentLabel.snp.bottom).offset(3)
                make.bottom.equalToSuperview().offset(-8)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class headerView: UIView {
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class YMTTaobaoCell: UITableViewCell {
    
    lazy var iconImage = { ()-> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "news")
        return image
    }()
    lazy var titleLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lab.font = wfont17
        lab.text = "アディダス公式旗艦店 "
        return lab
    }()
    lazy var subtitle = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        //lab.numberOfLines = 0
        lab.font = wfont17
        lab.text = "ブランドオフィシャルストア"
        return lab
    }()
    lazy var shop  = {() -> UIButton in
        let btn = UIButton()
        btn.setTitle("进店", for: .normal)
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
    
    lazy var contentLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lab.numberOfLines = 0
        lab.font = wfont15
        lab.text = "NMDスニーカーは、全国オリンピックのニットアッパーを使用し、レトロなスタイルを追求し、現代的な構造に溶け込み、ブーストミッドロー、EVAミッドローシンバル、快適な足を備えています"
        return lab
    }()
    
    lazy var contentImage = { ()-> UIImageView in
           let image = UIImageView()
           image.image = UIImage(named: "news")
           return image
       }()

    lazy var productImage = { ()-> UIImageView in
        let image = UIImageView()
        image.image = UIImage(named: "news")
        return image
    }()
    lazy var productTitleLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.numberOfLines = 0
        lab.font = wfont17
        lab.text = "KANUINブランドチャーリーズウォッチオスメカニカル "
        return lab
    }()
    lazy var productSubtitle = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        lab.font = wfont17
        lab.text = "期間限定購入"
        return lab
    }()
    lazy var productPrice = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        //lab.numberOfLines = 0
        lab.font = wfont17
        lab.text = "¥24999"
        return lab
    }()
    
    lazy var readLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        lab.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        //lab.numberOfLines = 0
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.text = "読んだ（20299）"
        return lab
    }()
    
    func baseTableViewCell(tb tableView: UITableView ,RID ReuseID: String) -> YMTTaobaoCell {
        var cell  = tableView.dequeueReusableCell(withIdentifier: ReuseID) as? YMTTaobaoCell
        if cell == nil {
            cell = YMTTaobaoCell.init(style: .value1, reuseIdentifier: ReuseID)
        }
        return cell!;
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none;
        
        if reuseIdentifier == "YMTTaobaoCell" {
            
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
            backgroundColor = .white
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
            
            iconImage.snp.makeConstraints { (make) in
                make.size.equalTo(60)
                make.top.equalToSuperview().offset(10)
                make.left.equalToSuperview().offset(40)
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
                make.left.equalTo(titleLabel.snp.right).offset(10)
                make.right.equalToSuperview().offset(-20)
                make.top.equalToSuperview().offset(20)
                make.height.equalTo(40)
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
                make.top.equalTo(contentImage.snp.bottom).offset(10)
                make.left.equalToSuperview().offset(10)
                make.height.equalTo(80)
                make.width.equalTo(80)
            }
            productTitleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(productImage.snp.right).offset(10)
                make.top.equalTo(contentImage.snp.bottom).offset(30)
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
                make.top.equalTo(productImage.snp.bottom).offset(20)
                make.left.equalToSuperview().offset(40)
                make.height.equalTo(40)
                make.width.equalTo(SCREEN_WIDTH / 2 )
            }
        }
    }
    var imageUrls: Array = Array<String>() {
        didSet{
           // collectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension YMTTaobaoCell : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
//    
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageUrls.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell : YMTTaobaoPhotoCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YMTTaobaoPhotoCollectionCell", for: indexPath) as! YMTTaobaoPhotoCollectionCell
//        cell.iconImage.image = UIImage(named: imageUrls[indexPath.row])
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        var  CoefficientW : Int = 0
//        var  CoefficientH : Int = 0
//        switch imageUrls.count {
//        case 2:
//            CoefficientH = 2
//            CoefficientW = 2
//        case 3:
//            CoefficientH = 2
//            CoefficientW = 3
//        case 4:
//            CoefficientH = 2
//            CoefficientW = 4
//        default:
//            CoefficientW = 4
//            CoefficientH = 4
//        }
//        return CGSize(width: (Int(collectionView.frame.size.width) - 2 * CoefficientW) / CoefficientW, height: (Int(collectionView.frame.size.width) - 2 * CoefficientH) / CoefficientH)
//    }
//}
