//
//  StartTests.swift
//  StartTests
//
//  Created by pactera on 2020/12/11.
//  Copyright © 2020 pactera. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import RxTest
import Alamofire
//import RxCocoa
@testable import Start

class StartTests: XCTestCase {
    
    //这是和主页进行绑定的 ViewModel
    var HomePageViewModel = YMTHomePageViewModel()
    var disposeBag = DisposeBag()
    
    private let sampleJson : [String: Any] = ["title": "test" ,"array1":[["title":"arra1test1"]],"array2": [
        ["title":"test1","good_price":"100","imageName":"menu_new","imageUrl":[]],]]
    
    
    private let sampleJson1 : [String : Any] = ["shop_name":"Shop_name","shop_info":"Shop_info","shop_flg":(4),"good_url_big":"Good_url_big"
        ,"good_url_small":"Good_url_small"]
    
    
    lazy var reposiroy : DownloadViewModel = { () ->DownloadViewModel in
        
        let reposiroy = DownloadViewModel()
        let list = ["list" : [
            ["title":"第一条.dmg" , "url" : "http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg" , "progress" : 0.0],
            ["title":"第二条.png" , "url" : "https://seopic.699pic.com/photo/50043/9886.jpg_wh1200.jpg" , "progress" : 0.0],
            ["title":"第三条.pptx" , "url" : "https://gmxjjzapi.dkvet.com/pactera.mp4" , "progress" : 0.0],]]
        let datas = [DownLoadSection(JSON: list)!]
        reposiroy.requests  =  DownLoadSection(JSON: list)!
        reposiroy.models.accept(datas)
        return reposiroy;
    }()
    
    //MARK -逻辑测试
    
    func test_HomePage_Json() throws{
        
        guard let repository =  HomePage(JSON: sampleJson) else {
            return XCTFail()
        }
        XCTAssertEqual(repository.title, "test")
        XCTAssertEqual(repository.array1![0].title, "arra1test1")
        XCTAssertEqual(repository.array2![0].title, "test1")
        XCTAssertEqual(repository.array2![0].good_price, "100")
        
        
        guard let reposirory1 = Items(JSON: sampleJson1) else{
            return XCTFail()
        }
        XCTAssertEqual(reposirory1.shop_name, "Shop_name")
        XCTAssertEqual(reposirory1.shop_info, "Shop_info")
        XCTAssertEqual(reposirory1.shop_flg, 4)
        XCTAssertEqual(reposirory1.good_url_big, "Good_url_big")
        XCTAssertEqual(reposirory1.good_url_small, "Good_url_small")
        
    }
    
    func test_Downlaod_pauseState() throws{
        
        let scheduler = TestScheduler(initialClock: 0)
        
        let canSendObserver = scheduler.createObserver([DownLoadSection].self)
        
        reposiroy.models.subscribe(canSendObserver).disposed(by: disposeBag)
        
        let inputState = scheduler.createHotObservable([Recorded.next(100, DownLoadState.pause)])
        
        let index  = IndexPath(row: 0, section: 0)
        
        inputState.subscribe(onNext: {[weak self] (n) in
            
            if n == DownLoadState.pause{
                self?.reposiroy.pause(index: index)
            }
        }).disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(reposiroy.models.value.first?.items[0].state, DownLoadState.continu)
        
    }
    
    func test_Downlaod_continuState() throws{
        
        let scheduler = TestScheduler(initialClock: 0)
        
        let canSendObserver = scheduler.createObserver([DownLoadSection].self)
        
        reposiroy.models.subscribe(canSendObserver).disposed(by: disposeBag)
        
        let inputState = scheduler.createHotObservable([Recorded.next(100, DownLoadState.continu)])
        
        let index  = IndexPath(row: 0, section: 0)
        
        inputState.subscribe(onNext: {[weak self] (n) in
            
            if n == DownLoadState.continu{
                self?.reposiroy.goOn(index: index)
            }
            
        }).disposed(by: disposeBag)
        
        scheduler.start()
        XCTAssertEqual(reposiroy.models.value.first?.items[0].state, DownLoadState.pause)
        
    }
    
    
    func test_Downlaod_noneState() throws{
        
        let scheduler = TestScheduler(initialClock: 0)
        
        let canSendObserver = scheduler.createObserver([DownLoadSection].self)
        
        reposiroy.models.subscribe(canSendObserver).disposed(by: disposeBag)
        
        let inputState = scheduler.createHotObservable([Recorded.next(100, DownLoadState.none)])
        let index  = IndexPath(row: 0, section: 0)
        
        inputState.subscribe(onNext: {[weak self] (n) in
            
            if n == DownLoadState.none{
                self?.reposiroy.start(index: index)
            }
            
        }).disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(reposiroy.models.value.first?.items[0].state, DownLoadState.pause)
    }
    
    
    func test_HomePage_index() throws{
        
        let reposirory = HomePageViewModel.models
        
        reposirory.accept([HomePage(JSON: sampleJson)!])
        
        let driver = reposirory.asDriver(onErrorJustReturn: [])
        
        let out =  YMTHomePageViewModel.Output(sections:driver)
        
        let scheduler = TestScheduler(initialClock: 0)
        
        let xs = scheduler.createHotObservable([Recorded.next(100, true),
                                                Recorded.next(200, false),
                                                Recorded.next(300, false),
                                                Recorded.next(400, true),
                                                Recorded.next(500, false),
                                                Recorded.next(600, false),
                                                Recorded.next(700, false),
                                                .completed(800)])
        xs.subscribe(onNext:{ [weak self](n)  in
            out.requstCommand.onNext(n)
            self?.HomePageViewModel.index = n ? 1 : (self?.HomePageViewModel.index)! + 1
        }).disposed(by: disposeBag)
        
        scheduler.start()
        XCTAssertEqual(self.HomePageViewModel.index, 4)
    }
    
    
    //MARK -异步测试
    func testAsyncRequest() throws {
        
        let exp = expectation(description: #function)
        
        AF.request("https://uni.xingyi.art/getTopList")
            .responseData { response in
                exp.fulfill()
                switch response.result {
                case .success:
                    print(response.result)
                    
                    XCTAssertNotNil(response, "return error");
                case let .failure(error):
                    XCTAssertNil(error, "request error");
                }
        }
        wait(for: [exp], timeout: 5)
    }
    
    
    //MARK -性能测试
    
    func testPerformance() throws {
        /// 性能测试中，相同的代码重复执行10次，最后统计计算时间和平均时间
        self.measure {
        // Put the code you want to measure the time of here.
            for _ in 0..<100{
                guard let repository =  HomePage(JSON: sampleJson) else {
                     return XCTFail()
                      }
                print(repository)
            }
        }
    }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            
            
        }
    }
    
}
