//
//  YMTHomePageViewController.swift
//  Start
//
//  Created by pactera on 2020/10/23.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class YMTTaobaoList: YMTBaseViewController, UIScrollViewDelegate {
    
    
    private  let viewModel = TaobaoListViewModel()
    
    private lazy var contentCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        var cv = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: layout)
        cv.isSkeletonable = true
        cv.backgroundColor = .clear
        // cv.dataSource = contentDataSource
        cv.register(YMTTaobaoTitleCollectionCell.self,forCellWithReuseIdentifier: YMTTaobaoCellID)
        cv.register(YMTDetalisCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetalisCollectionReusableViewID)
        cv.register(SkeletoneColletionCell.self, forCellWithReuseIdentifier: SkeletoneColletionCellID)
        return cv
    }()
    
    private lazy var contentDataSource = contentCollectionViewSkeletonedReloadDataSource()
    
    private func contentCollectionViewSkeletonedReloadDataSource() -> RxCollectionViewSkeletonedReloadDataSource<HomePage>  {
        return RxCollectionViewSkeletonedReloadDataSource(configureCell: { (ds, cv, ip, item) in
            
            if ip.section == 0 {
                
                let cell : YMTTaobaoTitleCollectionCell = cv.dequeueReusableCell(withReuseIdentifier: YMTTaobaoCellID, for: ip) as! YMTTaobaoTitleCollectionCell
                cell.contentLabel.text = item.shop_name
                if let url = URL(string: item.shop_url_small!) {
                    cell.iconImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "empty-image"), options: [.transition(.fade(1))])
                }
                return cell
            }
            
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
        }
            , configureSupplementaryView: {(dataSource ,collectionView, kind, indexPath) in
                
                let  section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetalisCollectionReusableViewID, for: indexPath) as! YMTDetalisCollectionReusableView
                section.titleContent.text =    titleContent
                section.titleContent.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                section.titleContent.textAlignment = .left
                return section
        }
            , reuseIdentifierForItemAtIndexPath: { _, _, indexPath in
                if indexPath.section == 0 {
                    return YMTTaobaoCellID
                }
                return SkeletoneColletionCellID
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
        navigationItem.title = perPrerefreshTitle
        
        view.addSubview(contentCollectionView)
        contentCollectionView.snp.makeConstraints { (make) in
            make.right.left.bottom.top.equalToSuperview().offset(0)
        }
        
        contentCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        //        contentCollectionView.prepareSkeleton(completion: { done in
        //                 self.view.showAnimatedGradientSkeleton()
        //            })
    }
    
    func bindUI(){
        
        let category  = BehaviorRelay<HomePageApi>(value: .homePageData(0))
        let Input = TaobaoListViewModel.Input(category: category)
        
        let datas  = viewModel.taoBaoListDate(input: Input)
        datas.sections.drive(contentCollectionView.rx.items(dataSource: contentDataSource)).disposed(by: disposeBag)
        
        contentCollectionView.es.addPullToRefresh {[unowned self] in
            datas.requstCommand.onNext(true)
            self.contentCollectionView.es.stopPullToRefresh()
        }
        
        contentCollectionView.es.addInfiniteScrolling { [unowned self] in
            datas.requstCommand.onNext(false)
            self.contentCollectionView.es.stopLoadingMore()
        }
        
        contentCollectionView.rx.prefetchItems.subscribe(onNext: { [weak self] idx in
            let needsFetch = idx.contains { $0.row >= (self!.viewModel.models.value[1].array2!.count) - 1}
            if needsFetch {
                datas.requstCommand.onNext(false)
            }
        }).disposed(by: disposeBag)
        
        datas.requstCommand.onNext(true)
    }
    
    deinit {
           print("deinit")
       }
}

extension YMTTaobaoList : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: (collectionView.frame.size.width - 8)/5, height: (collectionView.frame.size.width - 8)/5)
        }
        return CGSize(width: SCREEN_WIDTH - 40, height: 480)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section ==  0 {
            return CGSize(width: collectionView.frame.size.width, height: 40)
        }
        return CGSize(width:0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section ==  0 {
            return 0
        }
        return CGFloat(2 * minimumLineSpacing )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section ==  0 {
            return    UIEdgeInsets(top: CGFloat(0), left: CGFloat(0), bottom: CGFloat(0), right: CGFloat(0))
        }
        return UIEdgeInsets(top: CGFloat(2*minimumLineSpacing), left: CGFloat(2*minimumLineSpacing), bottom: CGFloat(2*minimumLineSpacing), right: CGFloat(2*minimumLineSpacing))
    }
}
