//
//  YMTHoemPageListModel.swift
//  Start
//
//  Created by pactera on 2020/11/11.
//  Copyright © 2020 pactera. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources



struct YMTTaoBaoModel :Mappable{
    
    var  array1: [TaoBao]?
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        array1 <- map["array1"]
    }
}

struct TaoBao: Mappable {
    
    var shop_name :String?
    var shop_info :String?
    var shop_id :Int = 0
    var good_id :Int = 0
    var shop_url_small :String?
    var shop_url_big :String?
    
    
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        shop_url_big <- map["shop_url_big"]
        shop_url_small <- map["shop_url_small"]
        good_id <- map["good_id"]
        shop_info <- map["shop_info"]
        shop_name <- map["shop_name"]
        shop_id <- map["shop_id"]
    }
}

extension YMTTaoBaoModel : SectionModelType {
    
    typealias Item = TaoBao
    var items: [TaoBao] {
        return self.array1!
    }
    init(original: YMTTaoBaoModel, items: [Item]) {
        self = original
        self.array1 = items
    }
}

