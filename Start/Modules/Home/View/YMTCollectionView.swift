//
//  YMTHomePageCollectionView.swift
//  Start
//
//  Created by pactera on 2020/10/27.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit

class YMTCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = .white
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.register(YMTCollectionCell.self,forCellWithReuseIdentifier: "YMTCollectionCell")
        self.register(YMTautoScrollViewCell.self,forCellWithReuseIdentifier: "YMTautoScrollViewCell")
        self.register(YMTCollectionTitleCell.self,forCellWithReuseIdentifier: "YMTCollectionTitleCell")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class YMTProductDetailsCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = CellColor
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.register(YMTDetalisCollectionTitleCell.self,forCellWithReuseIdentifier: "YMTDetalisCollectionTitleCell")
        self.register(YMTCollectionTitleCell.self,forCellWithReuseIdentifier: "YMTCollectionTitleCell")
        self.register(YMTDetalisCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "YMTDetalisCollectionReusableView")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class YMTHeardCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = .white
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.register(YMTTaobaoTitleCollectionCell.self,forCellWithReuseIdentifier: "YMTTaobaoTitleCollectionCell")
        self.register(YMTDetalisCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "YMTDetalisCollectionReusableView")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class YMTTaoBaoPhotoCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = .white
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.register(YMTTaobaoPhotoCollectionCell.self,forCellWithReuseIdentifier: "YMTTaobaoPhotoCollectionCell")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
