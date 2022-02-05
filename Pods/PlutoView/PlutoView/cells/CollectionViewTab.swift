//
//  CollectionViewTabCell.swift
//  CollapseHeader
//
//  Created by yusef naser on 6/13/20.
//  Copyright © 2020 yusef naser. All rights reserved.
//

import UIKit

open class CollectionViewTab : TabCell {
    
    public let collectionView : PaddingCollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let l = PaddingCollectionView(frame: .zero , collectionViewLayout: layout)
        l.backgroundColor = .white
        return l
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    private func initViews () {
        addViews()
        parentScroll = collectionView
    }
    private func addViews () {
        
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: 0).isActive = true
        
    }
    
}
