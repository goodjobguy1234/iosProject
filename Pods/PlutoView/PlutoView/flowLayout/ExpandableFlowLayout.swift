//
//  ExpandableFlowLayout.swift
//  CollapseHeader
//
//  Created by yusef naser on 6/13/20.
//  Copyright © 2020 yusef naser. All rights reserved.
//

import UIKit

class ExpandableFlowLayout : UICollectionViewFlowLayout {

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

       var cellLayoutAttributes : [IndexPath : UICollectionViewLayoutAttributes] = [:]
        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            guard let collectionView = collectionView else {
                return nil
            }
            self.itemSize = collectionView.frame.size
            return cellLayoutAttributes.values.filter { rect.intersects($0.frame) }
        }

        override func prepare() {
            guard let collectionView = collectionView else { return }
            let sections = [Int](0...collectionView.numberOfSections - 1)

            for section in sections {
                let itemCount = collectionView.numberOfItems(inSection: section)
                if itemCount == 0 {
                    return
                }
                let indexPaths = [Int](0...itemCount - 1).map { IndexPath(item: $0, section: section) }

                indexPaths.forEach { indexPath in
                    cellLayoutAttributes[indexPath] = layoutAttributesForItem(at: indexPath)
                }
            }

        }

        override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
            guard let collectionView = collectionView else { return nil }
            let item = UICollectionViewLayoutAttributes(forCellWith: indexPath)
             let width = collectionView.frame.width
             let height = collectionView.frame.height
            
            item.frame = CGRect(x: CGFloat(indexPath.row) * width , y: 0, width: width , height: height )
            
            return item
        }

    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return false
    }
    
    
}
