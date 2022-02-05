//
//  ScrollViewTabCell.swift
//  CollapseHeader
//
//  Created by yusef naser on 6/13/20.
//  Copyright © 2020 yusef naser. All rights reserved.
//

import UIKit

open class ScrollViewTab : TabCell {
    
    open lazy var scrollView : UIScrollView = {
       let s = UIScrollView()
        s.addSubview(parentView)
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.topAnchor.constraint(equalTo: s.topAnchor , constant: 0).isActive = true
        parentView.leadingAnchor.constraint(equalTo: s.leadingAnchor , constant: 0).isActive = true
        parentView.trailingAnchor.constraint(equalTo: s.trailingAnchor , constant: 0).isActive = true
        
        parentView.bottomAnchor.constraint(lessThanOrEqualTo: s.bottomAnchor , constant: -8 ).isActive = true
        
        
        parentView.widthAnchor.constraint(equalTo: s.widthAnchor , multiplier: 1).isActive = true
        parentView.heightAnchor.constraint(greaterThanOrEqualTo: s.heightAnchor , multiplier: 1).isActive = true
        
        
        return s
    }()
    
    open var parentView = UIView ()
    
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
        parentScroll = scrollView
    }
    private func addViews () {
        contentView.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: 0).isActive = true
        
    }
    
    open func addBottomAnchor(view : UIView , constant : CGFloat) {
        view.bottomAnchor.constraint(lessThanOrEqualTo: parentView.bottomAnchor , constant: -constant ).isActive = true
    }
    
}
