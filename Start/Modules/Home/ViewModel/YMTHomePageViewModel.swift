//
//  YMTHomePageViewModel.swift
//  Start
//
//  Created by pactera on 2020/10/23.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper



class YMTHomePageViewModel: NSObject {
    
    //MARK - 全局变量
    
    /// Rx销毁监听
    var disposeBag = DisposeBag()
    
    /// 列表数据集合
    var models = BehaviorRelay<[HomePage]>(value: [])
    
    /// 分页计数
    var index : Int = 1
    
    /// 延迟了downlaod里ViewModel属性的生命周期   ，需要懒加载控制器 防止内存溢出
    lazy var downLoadVC  = {() -> DownLoadController in
          let vc = DownLoadController()
         return vc
     }()
    
    //MARK - 输入源
    
    struct Input {
        
        /// 参数 categroy 请求接口 ，这里没有使用
        var category  = BehaviorRelay<HomePageApi>(value: .homePageData(0))
        
        /// 导航栏用于跳转控页面
        var navigationVC : UINavigationController
        
        /// 下载的控制器对应的ViewModel
        var downloadViewModel : DownloadViewModel
        
        /// 下载控制器对应的数据序列
        var downloadDatas : Driver<[DownLoadSection]>
    }
    
    //MARK - 输出源
    
    struct Output {
        
        /// 参数1 sections 返回给Contorller的数据序列
        let sections: Driver<[HomePage]>
        
        /// 参数2 requstCommand 当前用户操作状态，true上拉 flase 下拉
        let requstCommand = PublishSubject<Bool>()
        
        /// 参数3 导航命令
        let navigationCommand = PublishSubject< IndexPath>()
    }
    
    /// 服务器返回数据格式和页面UI搭建不匹配需要进行单独处理
    /// 加载本地数据，之后进行合并
    func loadCacheData(){
    
        ///初始本地数据 给 imageUrl 默认值 防止轮播图警告
        let result1 = ["title": "第一组数据初始化" ,
                       "array1": [
                       ["title":"无","imageName":"menu_new","imageUrl":[]],]
                       ,"array2": [
                        ["title":"新产品","imageName":"menu_new","imageUrl":[]],]] as [String : Any]
        
        let result2 = ["title": "第二条" ,"array1":[],"array2": [
            ["title":"无感刷新","imageName":"menu_new"],
            ["title":"ダウンロード","imageName":"menu_hot"],
            ["title":"骨架屏","imageName":"menu_supermarket"],
            ["title":"海鲜","imageName":"menu_seafood"],
            ["title":"活动","imageName":"menu_activity"],
            ["title":"折扣","imageName":"menu_discount"],
            ["title":"旅行","imageName":"menu_travel"],
            ["title":"拍卖","imageName":"menu_auction"],
            ["title":"充值","imageName":"menu_pay"],
            ["title":"分类","imageName":"menu_more"],]] as [String : Any]
        let result3 = ["title": "第三组数据初始化" ,"array1":[],"array2": []] as [String : Any]
        
        var group1 : HomePage  = HomePage(JSON: result1)!
        let group2 : HomePage  = HomePage(JSON: result2)!
        let group3 : HomePage  = HomePage(JSON: result3)!
        
        /// 查看是否有轮播图本地缓存数据
        let  urlImages =  CoreDataManager.shared.getHomePageImages()
             if urlImages.count > 0{
                    group1.array2![0].imageUrl = urlImages
         }
        models.accept([group1,group2,group3])
    }
    
    /*
     * 方法名称 loadHomePageListLocalDate 获取数据集合
     * 参数 Input.category  请求类型  这里没有用到
     * 返回值 Observable<[YMTTaoBaoModel]   可监听序列
     **/
    
    func loadHomePageListLocalDate(input : Input) -> Output {
        
        ///加载本地数据
        loadCacheData()
        
        ///初始化输入源
        let out  = Output(sections: models.asDriver(onErrorJustReturn: []))
        
        out.navigationCommand.subscribe(onNext: {[weak self] index in
                        if index.row == 0 && index.section == 1 {
                            let vc = YMTTaobaoList()
                           input.navigationVC.pushViewController(vc, animated: true)
                        }
                        if index.row == 1 && index.section == 1 {
                            self?.downLoadVC.viewModel = input.downloadViewModel
                            self?.downLoadVC.datas = input.downloadDatas
                            input.navigationVC.pushViewController(self!.downLoadVC, animated: true)
                        }
                        if index.row == 2 && index.section == 1 {
                            let vc = SkeletonViewController()
                           input.navigationVC.pushViewController(vc, animated: true)
                        }
            }).disposed(by: self.disposeBag)
        
        out.requstCommand.subscribe(onNext: { [unowned self] isReloadData in
            self.index = isReloadData ? 1 : self.index + 1
            HomePageProvider.rx.request(.homePageData( self.index))
                .mapObject(HomePage.self)
                .map{  group in
                    ///数据调整并进行缓存存储
                    var imagUrl : Array<String> = []
                    for i in 0..<group.array1!.count{
                        let url = group.array1?[i]
                        imagUrl.append((url?.url_big)!)
                    }
                    CoreDataManager.shared.deleteHomePageImages()
                    CoreDataManager.shared.saverHomePageImages(urls: imagUrl)

                    var  s = self.models.value
                    s[0].array2![0].imageUrl = imagUrl
                    s[2].array2 = s[2].array2! + group.array2!
                    self.models.accept(s)
            }.asObservable().subscribe({ (event) in
                switch event{
                case let .next(modelArr):
                    print(modelArr)
                case let .error(error):
                    print(error)
                    print("请求错误")
                case .completed:
                    print("请求完成")
                }
            }).disposed(by: self.disposeBag)
        }).disposed(by: self.disposeBag)
        
        return out
    }
}


