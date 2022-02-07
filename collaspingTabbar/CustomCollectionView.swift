//
//  CustomCollectionView.swift
//  collaspingTabbar
//
//  Created by macbook on 6/2/2565 BE.
//

import Foundation
import UIKit

class CustomCollectionView: UICollectionView {
    
    override var adjustedContentInset: UIEdgeInsets {
             if self.frame.height > contentSize.height  {
                  let heightBottom =
                 ( self.frame.height - contentSize.height ) + 0.5
                return UIEdgeInsets(
                       top: self.contentInset.top + 0.5 ,
                       left: self.contentInset.left ,
                       bottom: heightBottom ,
                      right: self.contentInset.right )
             }
          return UIEdgeInsets(
                 top: self.contentInset.top + 0.5 ,
                 left: self.contentInset.left ,
                 bottom: self.contentInset.right,
                right: self.contentInset.right )
        }
}
