//
//  SkeletonViewController.swift
//  Start
//
//  Created by pactera on 2020/12/8.
//  Copyright © 2020 pactera. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class SkeletonViewController: YMTBaseViewController, UIScrollViewDelegate {
    
    /*
     * collectionViewSkeletonedReloadDataSource 骨架屏单与RXswift配合的方法用于进行与Collection进行绑定操作
     * setUpUI  UI设置
     * bindUI   数据绑定
     **/
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: SCREEN_WIDTH - 40, height: 480)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        return layout
    }()
    
    private let viewModel = SkeletonViewViewModel()
    
    private lazy var collectionView: UICollectionView = {
        var cv = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: self.flowLayout)
        cv.isSkeletonable = true
        cv.backgroundColor = .clear
        cv.dataSource = dataSource
        cv.register(SkeletoneColletionCell.self, forCellWithReuseIdentifier: SkeletoneColletionCellID)
        return cv
    }()
    
    private lazy var dataSource = collectionViewSkeletonedReloadDataSource()
    
    private func collectionViewSkeletonedReloadDataSource() -> RxCollectionViewSkeletonedReloadDataSource<HomePage>  {
        return RxCollectionViewSkeletonedReloadDataSource(configureCell: { (ds, cv, ip, item) in
            let cell :SkeletoneColletionCell  = cv.dequeueReusableCell(withReuseIdentifier: SkeletoneColletionCellID, for: ip) as! SkeletoneColletionCell
            
            cell.titleLabel.text = item.good_name
            cell.contentLabel.text = item.good_info! + "ダウンキングファイバーは100％ポリエステルで、手触りが非常に柔らかく、耐摩耗性と耐久性があります。ガオ密度は防風性と耐寒性があり"
            if let url = URL(string: item.good_url_small!) {
                cell.iconImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "empty-image"), options: [.transition(.fade(1))])
            }
            if let url = URL(string: item.good_url_small!) {
                cell.productImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "empty-image"), options: [.transition(.fade(1))])
            }
            if let url = URL(string: item.good_url_big!) {
                cell.contentImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "empty-image"), options: [.transition(.fade(1))])
            }
            return cell
        }, reuseIdentifierForItemAtIndexPath: { _, _, _ in
            return "SkeletoneColletionCell"
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindUI()
    }
    
   override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
   
    func setUpUI(){
        view.isSkeletonable = true
        navigationItem.title = "空载"
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.right.top.bottom.left.equalToSuperview().offset(0)
        }
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)

        collectionView.prepareSkeleton(completion: { done in
            self.view.showAnimatedGradientSkeleton()
        })
    }
    
    func bindUI(){
        let  data =  viewModel.shopListDate()
        data.drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            data.drive(onNext: { [weak self] valid  in
                if valid[0].items.count > 0{
                    self!.view.hideSkeleton()
                }
            }).disposed(by: self.disposeBag)
        }
    }
}

extension SkeletonViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return CGFloat(2 * minimumLineSpacing )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: CGFloat(2*minimumLineSpacing), left: CGFloat(2*minimumLineSpacing), bottom: CGFloat(2*minimumLineSpacing), right: CGFloat(2*minimumLineSpacing))
    }
}
