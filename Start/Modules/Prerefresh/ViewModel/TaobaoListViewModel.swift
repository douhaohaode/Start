//
//  TaobaoListViewModel.swift
//  Start
//
//  Created by pactera on 2020/12/7.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper


class TaobaoListViewModel: NSObject {
    
    /// Rx销毁监听
    var disposeBag = DisposeBag()
   
    /// 列表数据集合
    var models = BehaviorRelay<[HomePage]>(value: [])
    
    /// 头部数据集合
    var heards = BehaviorRelay<[YMTTaoBaoModel]>(value:[])
    
   /// 分页计数
    var index : Int = 1
    
    /*
     * 输入源
     * 参数 categroy 请求类型
     **/
    struct Input {
        // 请求类型
        var category  = BehaviorRelay<HomePageApi>(value: .getShopList(0))
    }
    /*
     * 输出源
     * 参数1 sections 返回给Contorller的数据序列
     * 参数2 requstCommand 当前用户操作状态，true上拉 flase 下拉
     **/
    struct Output {
        
        let sections: Driver<[HomePage]>
        
        let requstCommand = PublishSubject<Bool>()
    }
    
    
    /*
     * 方法名称 shopListDate 获取商铺列表
     * 参数 Input.category  请求类型  这里没有用到
     * 返回值 Observable<[YMTTaoBaoModel]   可监听序列
     **/
    func shopListDate(input : Input) -> Observable<[YMTTaoBaoModel]>{
        
        return HomePageProvider.rx.request(.getShopList(self.index))
            .mapObject(YMTTaoBaoModel.self)
            .map{ [$0] }.asObservable()
    }
    
    /*
     * 方法名称 taoBaoListDate 获取商品列表
     * 参数 Input.category  请求类型
     * 返回值 Output   包含 1.数据总集合序列Driver<[HomePage]>   2.用户刷新操作 PublishSubject<Bool>()
     **/
    func taoBaoListDate(input : Input) -> Output {
        
        loadCacheData()
        let out  = Output(sections: models.asDriver(onErrorJustReturn: []))
        out.requstCommand.subscribe(onNext: { [unowned self] isReloadData in
            self.index = isReloadData ? 1 : self.index + 1
            HomePageProvider.rx.request(.getShopList(self.index))
                .mapObject(HomePage.self)
                .map{  group in
                    
                    var  s = self.models.value
                    s[0].array2! = group.array1!
                    s[1].array2 = s[1].array2! + group.array2!
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
    
    /* 服务器返回数据格式和页面UI搭建不匹配需要进行单独处理
        * 加载本地数据，之后进行合并
        **/
       func loadCacheData(){
           //初始本地数据 给 imageUrl 默认值 防止轮播图警告
           let result = ["title": "第三组数据初始化" ,"array1":[],"array2": []] as [String : Any]
           let group1 : HomePage  = HomePage(JSON: result)!
           let group2 : HomePage  = HomePage(JSON: result)!
           models.accept([group1,group2])
       }
    
}
