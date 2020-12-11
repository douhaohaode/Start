//
//  YMTBaseTableView.swift
//  Start
//
//  Created by pactera on 2020/11/5.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit

class YMTBaseTableView: UITableView {

     override init(frame: CGRect, style: UITableView.Style) {
          super.init(frame:frame , style:style)
          if #available(iOS 11.0, *){
              contentInsetAdjustmentBehavior = contentInsetAdjustmentBehavior
              contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0);
              scrollIndicatorInsets = contentInset;
              estimatedRowHeight = 0;
              estimatedSectionHeaderHeight = 0;
              estimatedSectionFooterHeight = 0;
          }
      }
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

}
