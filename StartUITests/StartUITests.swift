//
//  StartUITests.swift
//  StartUITests
//
//  Created by pactera on 2020/12/11.
//  Copyright © 2020 pactera. All rights reserved.
//

import XCTest

class StartUITests: XCTestCase {
    
    var app:XCUIApplication!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func example(app :XCUIApplication){
        
        app.launch()
        
        /// 该元素是否存在 存在 代表 第一次启动
        if app.buttons["跳 过"].exists {
            app.buttons["跳 过"].tap()
        }else{
            app.buttons["跳过广告3"].tap()
        }
        for _ in 0..<5{
            app.buttons["Order"].tap()
            app.buttons["Personal"].tap()
            app.buttons["Freight"].tap()
            app.buttons["HomePage"].tap()
        }
        
        ///        textField操作
        ///        let searchField = app.searchFields.element(boundBy: 0)
        ///        searchField.tap()
        ///        searchField.typeText("banana")
        
        let collectionView = app.collectionViews.element(boundBy: 0)
        collectionView.cells.element(boundBy: 0).swipeUp()
        collectionView.cells.element(boundBy: 0).swipeDown()
        let success = collectionView.waitForExistence(timeout: 3)
        XCTAssert(success, "Fail to Find Collection View")
        let downLoadCollectionCell = collectionView.cells.element(boundBy: 2)
        downLoadCollectionCell.tap()
        
        let downLoadTableView = app.tables.element(boundBy: 0)
        let success1 = downLoadTableView.waitForExistence(timeout: 3)
        XCTAssert(success1, "Fail to Find Collection View")
        for i in 0..<1{
            let _ =    downLoadTableView.cells.element(boundBy: i).buttons["開始下"].tap()
        }
        sleep(5)
        app.buttons["Back"].tap()
        sleep(2)
        let SkeletonViewCollectionCell = collectionView.cells.element(boundBy: 3)
        SkeletonViewCollectionCell.tap()
        sleep(2)
        app.buttons["Back"].tap()
        sleep(2)
        
        let PrerefreshViewCollectionCell = collectionView.cells.element(boundBy: 1)
        PrerefreshViewCollectionCell.tap()
        
        ///  let PrerefreshView = app.collectionViews.element(boundBy: 0)
        ///  for _ in 0..<10{
        ///  PrerefreshView.cells.element(boundBy: 0).swipeUp()
        ///}
        app.buttons["Back"].tap()
        sleep(3)
        
        /// 按home按键进入后台
        XCUIDevice.shared.press(.home)
        XCTAssertTrue(app.wait(for: .runningBackground, timeout: 3))
        XCTAssertTrue(app.state == .runningBackground)
        /// 进入前台
        app.activate()
        XCTAssertTrue(app.state == .runningForeground)
        
        for _ in 0..<5{
            app.buttons["Order"].tap()
            app.buttons["Personal"].tap()
            app.buttons["Freight"].tap()
            app.buttons["HomePage"].tap()
        }
        /// 进入下载页面
        downLoadCollectionCell.tap()
        sleep(3)
        app.activate()
        XCTAssertTrue(app.state == .runningForeground)
        
        sleep(3)
        app.buttons["Back"].tap()
        //Kill the App
        app.terminate()
        app.launch()
        app.buttons["跳过广告3"].tap()
        sleep(3)
        app.terminate()
        
    }
    
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        app = XCUIApplication()
        
        for _ in 0..<2{
            example(app: app)
        }
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIElement {
    func scrollToElement(_ element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
