//
//  DowdLoadModel.swift
//  Start
//
//  Created by pactera on 2020/12/4.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import ObjectMapper
import RxDataSources
import Alamofire
import RxSwift
import RxCocoa

public enum DownLoadState : String {
    
    case none  =  "開始下"  //默认 开始
    case pause =  "暂停"     //暂停
    case continu = "继续"    //继续
    case complete = "大人"   //完成
    case error = "错误"      //错误
}

struct DownLoadItem : Mappable {
    
    var url = ""
    var progress = 0.0
    var state = DownLoadState.none
    var title = ""
    var request =  AF.download("https://httpbin.org/image/png")
        .downloadProgress { progress in
            print("Download Progress: \(progress.fractionCompleted)")
    }
    .responseData { response in
    }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        url        <- map["url"]
        progress   <- map["progress"]
        state      <- map["state"]
        title      <- map["title"]
        request    <- map ["request"]
    }
}

struct DownLoadSection : Mappable{
    
    var list : [DownLoadItem]?
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        list <- map["list"]
    }
}

extension DownLoadSection : SectionModelType{
    
    var items: [DownLoadItem] {
        return self.list!
    }
    typealias Item = DownLoadItem
    init(original: DownLoadSection, items: [DownLoadSection.Item]) {
        self = original
        self.list = items
    }
}



