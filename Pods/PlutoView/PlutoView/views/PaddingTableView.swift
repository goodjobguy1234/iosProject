//
//  PaddingTableView.swift
//  CollapseHeader
//
//  Created by yusef naser on 6/13/20.
//  Copyright © 2020 yusef naser. All rights reserved.
//

import UIKit

open class PaddingTableView : UITableView {
    
    open override var adjustedContentInset: UIEdgeInsets {
           if self.frame.height > contentSize.height  {
               let heightBottom = ( self.frame.height - contentSize.height ) + 1
               return UIEdgeInsets(top: self.contentInset.top + 1 , left: self.contentInset.left , bottom: heightBottom , right: self.contentInset.right )
           }
           return UIEdgeInsets(top: self.contentInset.top + 1 , left: self.contentInset.left , bottom: self.contentInset.right , right: self.contentInset.right )
       }
       
    
}
