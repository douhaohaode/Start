//
//  SkeletonViewViewModel.swift
//  Start
//
//  Created by pactera on 2020/12/8.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SkeletonViewViewModel: NSObject {
    
    func shopListDate() -> Driver<[HomePage]>{
          return HomePageProvider.rx.request(.getShopList(1))
          .mapObject(HomePage.self)
              .map{ [$0] }.asDriver(onErrorJustReturn: [])
      }
}
