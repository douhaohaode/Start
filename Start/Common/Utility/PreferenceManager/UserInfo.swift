//
//  UserInfo.swift
//  Start
//
//  Created by pactera on 2020/11/4.
//  Copyright © 2020 pactera. All rights reserved.
//

import Foundation
import UIKit

final class UserInfo: NSObject, NSCoding {
    
    var id = 0
    var name = ""
    var password = ""
    var token = ""
    var account = ""
    
    convenience init(id: Int, name: String ,password: String,token: String,account: String) {
        self.init()

        self.id = id
        self.name = name
        self.password = password
        self.token = token
        self.account = account
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()

        for child in Mirror(reflecting: self).children {
            if let key = child.label {
                setValue(aDecoder.decodeObject(forKey: key), forKey: key)
            }
        }
    }
    
    func encode(with aCoder: NSCoder) {
        for child in Mirror(reflecting: self).children {
            if let key = child.label {
                aCoder.encode(value(forKey: key), forKey: key)
            }
        }
    }
}
