//
//  YMTHomePageController.swift
//  Start
//
//  Created by 王健 on 2020/10/25.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import ESPullToRefresh
import Kingfisher

class YMTHomePageController: YMTBaseViewController {
    
    private lazy var collectionView = { () -> YMTCollectionView in
        let flowyout = UICollectionViewFlowLayout()
        flowyout.minimumLineSpacing = 1
        flowyout.minimumInteritemSpacing = 0
        let colleView = YMTCollectionView(frame:CGRect.zero,collectionViewLayout: flowyout)
        return colleView
    }()
    
    ///在当前页面创建 downLaodViewModel
    ///延长downLaodViewModel生命周期
    private var downLoadViewModel =  DownloadViewModel()
    /// downLoad 控制器 数据序列
    private  lazy var downloadDatas = { ()  -> Driver<[DownLoadSection]> in
        var datas = downLoadViewModel.fetchData()
        return   datas
    }()
    
    private let viewModel = YMTHomePageViewModel()
    
    ///RXDataSource 用法
    ///用于与TableView或者CollectionView进行绑定
    let dataSource = RxCollectionViewSectionedReloadDataSource<HomePage>(
        configureCell:  { (dataSource, collectionView, indexPath, element) -> UICollectionViewCell in
            switch indexPath.section {
            case 0:
                let cell : YMTautoScrollViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YMTautoScrollViewCell", for: indexPath) as! YMTautoScrollViewCell
                
                cell.autoScrollView.images = element.imageUrl
                return cell
            case 1 :
                let cell : YMTCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YMTCollectionCell", for: indexPath) as! YMTCollectionCell
                cell.iconImage.image = UIImage(named: element.imageName!)
                cell.contentLabel.text = element.title
                return cell
            default :
                let cell : YMTCollectionTitleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YMTCollectionTitleCell", for: indexPath) as! YMTCollectionTitleCell
                cell.titleLabel.text = element.good_name
                cell.activitiesLabel.text = element.good_info
                cell.priceLabel.text = "$" + element.good_price!
                if let url = URL(string: element.good_url_big!) {
                    cell.iconImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "empty-image"), options: [.transition(.fade(1))])        }
                return cell
            }
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
          setupUI()
          bindUI()
    }
}

extension YMTHomePageController {
    
    fileprivate func setupUI() {
             
        buildNavigationView()
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview().offset(0)
        }
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
    fileprivate func bindUI() {
        
        ///input 为输入源 目前这个demo比较简单，input没有利用上，这里的category没有用到
        let category  = BehaviorRelay<HomePageApi>(value: .homePageData(0))
        
        let Input = YMTHomePageViewModel.Input(category: category,navigationVC: navigationController!,downloadViewModel: downLoadViewModel,downloadDatas:downloadDatas)
        
        let Output  = viewModel.loadHomePageListLocalDate(input: Input)
        Output.sections.drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        /// 导航栏跳转
        collectionView.rx.itemSelected.subscribe(onNext:{ index in
            
            Output.navigationCommand.onNext(index)
            
        }).disposed(by:disposeBag)
        
        /// 无感刷新
        collectionView.rx.prefetchItems.subscribe(onNext: { [weak self] idx in
            let needsFetch = idx.contains { $0.row >= (self!.viewModel.models.value[2].array2!.count) - 1}
            if needsFetch {
                Output.requstCommand.onNext(false)
            }
        }).disposed(by: disposeBag)
        /// 下拉刷新
        collectionView.es.addPullToRefresh {[unowned self] in
            Output.requstCommand.onNext(true)
            self.collectionView.es.stopPullToRefresh()
        }
        /// 下拉加载
        collectionView.es.addInfiniteScrolling { [unowned self] in
            Output.requstCommand.onNext(false)
            self.collectionView.es.stopLoadingMore()
        }
        
        Output.requstCommand.onNext(true)
    }
}


extension YMTHomePageController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.size.width, height: 230)
        case 1:
            return CGSize(width: (collectionView.frame.size.width - CGFloat(minimumLineSpacing)/2)/5, height: (collectionView.frame.size.width )/5)
        default:
            return CGSize(width: (collectionView.frame.size.width - 3 * CGFloat(minimumLineSpacing))/2, height: (collectionView.frame.size.width )/2 + 100)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 2 {
            return CGFloat(minimumLineSpacing + 5)
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 2 {
            return UIEdgeInsets(top: CGFloat(minimumLineSpacing), left: CGFloat(minimumLineSpacing), bottom: CGFloat(minimumLineSpacing), right: CGFloat(minimumLineSpacing))
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


