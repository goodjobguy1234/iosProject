//
//  PlutoView.swift
//  Pluto
//
//  Created by yusef naser on 9/15/20.
//  Copyright © 2020 Yusef. All rights reserved.
//

import UIKit

public protocol PlutoDelegate : class  {
    func getCountTabs () -> Int
    func tabForIndex (index : Int) -> TabCell?
    func getPageIndex ( page : Int )
    func didScrollView(_ scrollView: UIScrollView)
}

public enum EnumHeightType {
    case fixed(float : CGFloat)
  //  case automatic
    case none
}

open class PlutoView : UIView {
    
    open weak var delegate : PlutoDelegate?
    
    private var headerMaxHeight : CGFloat = 0 {
        didSet{
            heightHeaderView?.constant = headerMaxHeight
        }
    }
    
    private var headerMaxHeightType : EnumHeightType = .none

    private var headerMinHeight : CGFloat = 50 + UIApplication.shared.statusBarFrame.height
    
    private var heightHeaderView : NSLayoutConstraint?
    
    private var pageIndex : Int = 0
    
    public init(maxHeightType : EnumHeightType , headerMinHeight : CGFloat =  50 + UIApplication.shared.statusBarFrame.height ) {
        super.init(frame: .zero)
        
        self.headerMaxHeightType = maxHeightType
        
        switch maxHeightType {
        case .none:
            self.headerMinHeight = 0
            heightHeaderView?.constant = 0
            addViews()
            break
        case .fixed(let float):
            self.headerMinHeight = headerMinHeight
            headerMaxHeight = float
            heightHeaderView?.constant = headerMaxHeight
            break
        }
        
        initViews()
    }
    
    
    private var header  : UIView = {
        let l = UIView()
        l.backgroundColor = .gray
        return l
    }()
    
    private let collectionView : UICollectionView = {
        let layout = ExpandableFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let l = UICollectionView(frame: .zero, collectionViewLayout: layout)
        l.register(UICollectionViewCell.self , forCellWithReuseIdentifier: UICollectionViewCell.getIdentifier() )
        l.register(TabCell.self , forCellWithReuseIdentifier: TabCell.getIdentifier())
        l.backgroundColor = .white
        l.isPagingEnabled = true
        l.showsHorizontalScrollIndicator = false
        return l
    }()
    
  
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        initViews()
//    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    private func initViews () {

    }
    private func addViews () {
        
        addSubview(header)
        addSubview(collectionView)
        
        header.translatesAutoresizingMaskIntoConstraints = false
        header.topAnchor.constraint(equalTo: topAnchor , constant: 0).isActive = true
        header.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 0).isActive = true
        header.trailingAnchor.constraint(equalTo: trailingAnchor , constant: 0).isActive = true
        heightHeaderView = header.heightAnchor.constraint(equalToConstant: headerMaxHeight )
        heightHeaderView?.isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: header.bottomAnchor , constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor , constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: 0).isActive = true
        
        
    }
    
//    open override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        switch headerMaxHeightType {
//        case .automatic :
//            var h = header.frame.height
//
//            if h == UIScreen.main.bounds.height {
//                h = 250
//                print("Please add correct constraints")
//            }
//
//            headerMaxHeight = h
//
//            break
//        case .fixed(let float) :
//            headerMaxHeight = float
//            break
//        case .none :
//            headerMaxHeight = 0
//
//            break
//        default:
//            break
//        }
//        heightHeaderView = header.heightAnchor.constraint(equalToConstant: headerMaxHeight )
//        heightHeaderView?.isActive = true
//    }
//
    
    open func registerTabs (tabs : [TabCell.Type]) {
         
          tabs.forEach { (c) in
              collectionView.register(c.self , forCellWithReuseIdentifier: c.getIdentifier() )
          }
          collectionView.delegate = self
          collectionView.dataSource = self
      }
    
    open func initTab (type : TabCell.Type ,  index : Int ) -> TabCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type.getIdentifier() , for: IndexPath(row: index , section: 0)) as! TabCell
        cell.parentScroll?.delegate = self
        cell.parentScroll?.setContentOffset(.zero , animated: false )
        return cell
    }
    
    open func addHeader(header : UIView) {
        self.header.removeFromSuperview()
        self.collectionView.removeFromSuperview()
        self.header = header
        addViews()
    }
    
    
    public func scrollToTab (index : Int) {
        guard (delegate?.getCountTabs() ?? 0) > index else {
            return
        }
        collectionView.scrollToItem(at: IndexPath(row: index , section: 0 ) , at: .init(), animated: true )
    }
    
    public func reloadTabs () {
        collectionView.reloadData()
    }
    
    
}

extension PlutoView : UICollectionViewDelegate , UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.getCountTabs() ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = delegate?.tabForIndex(index: indexPath.row) ?? TabCell()
        
        return cell
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.frame.width == 0 {
            return
        }
        let newPageIndex = Int(round(scrollView.contentOffset.x/scrollView.frame.width))
        
        if scrollView == collectionView {
            if pageIndex != newPageIndex {
                pageIndex = newPageIndex
                delegate?.getPageIndex( page: pageIndex )
            }
            
            return
        }
        
        let y: CGFloat = scrollView.contentOffset.y
        guard let headerViewHeightConstraint = heightHeaderView else {return}
        let newHeaderViewHeight: CGFloat =
                  headerViewHeightConstraint.constant - y
        if newHeaderViewHeight > headerMaxHeight {
           headerViewHeightConstraint.constant = headerMaxHeight
        } else if newHeaderViewHeight <= headerMinHeight {
           headerViewHeightConstraint.constant = headerMinHeight
        } else {
           headerViewHeightConstraint.constant = newHeaderViewHeight
           scrollView.contentOffset.y = 0 // block scroll view
        }
        
        delegate?.didScrollView(scrollView )
        
    }
    
}


 extension UITableViewCell {
    static func getIdentifier () -> String  {
        return String(describing: self)
    }
    
}

 extension UICollectionViewCell {
    static func getIdentifier () -> String  {
        return String(describing: self)
    }
}
