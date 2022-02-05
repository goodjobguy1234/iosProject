//
//  TableViewTabCell.swift
//  CollapseHeader
//
//  Created by yusef naser on 6/13/20.
//  Copyright © 2020 yusef naser. All rights reserved.
//

import UIKit

open class TableViewTab : TabCell {
    
    public let tableView : PaddingTableView = {
        let l = PaddingTableView()
        l.tableFooterView = UIView()
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
        parentScroll = tableView
    }
    private func addViews () {
        
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: 0).isActive = true
        
    }
    
}
