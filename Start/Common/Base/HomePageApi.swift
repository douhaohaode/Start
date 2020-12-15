//
//  HomePageApi.swift
//  Start
//
//  Created by pactera on 2020/10/26.
//  Copyright © 2020 pactera. All rights reserved.
//

import Foundation
import Moya
import RxMoya

let HomePageProvider = MoyaProvider<HomePageApi>()

//请求分类
public enum HomePageApi {
    case homePageData(Int)
    case getShopList (Int)
    case homePagelist(String,Int,Int)
    case playlistDate(Dictionary<String, Any>)
}
 

//请求配置
extension HomePageApi: TargetType {
   
    //服务器地址
    /*http://192.168.103.45:8888/getTopList

     http://192.168.103.32:8080/test
     */
    public var baseURL: URL {
        switch self {
        case .homePageData(_):
            return URL(string: "https://uni.xingyi.art")!
        case.getShopList:
            return URL(string: "https://uni.xingyi.art")!
        case .homePagelist(_,_,_):
            return URL(string: "")!
        case .playlistDate(_):
            return URL(string: "")!
        }
    }
     
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .homePageData(_):
            return "/getTopList"
        case .getShopList:
            return "/getShopList"
        case .homePagelist(_,_,_):
            return "/data/category/all"
        case .playlistDate(_):
            return "/j/mine/playlist"
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        switch self {
        case .homePageData(_):
            return .get
        case .getShopList(_):
            return .get
        case .homePagelist(_,_,_):
            return .post
        case .playlistDate(_):
            return .post
        }
    }
     
    //请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .homePageData(let index):
            var params: [String: Any] = [:]
            params["page"] = index
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        case .getShopList(let index):
            var params: [String: Any] = [:]
            params["page"] = index
           return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
            
        case .homePagelist(let channel ,let size,let index):
            var params: [String: Any] = [:]
            params["channel"] = channel
            params["size"] = size
            params["index"] = index
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
       
        case .playlistDate(let dict):
            return .requestParameters(parameters: dict,
                                                 encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
     
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
     
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
     
    //请求头
    public var headers: [String: String]? {
        return nil
    }
}
