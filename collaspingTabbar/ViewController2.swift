//
//  ViewController.swift
//  collaspingTabbar
//
//  Created by macbook on 1/2/2565 BE.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet var contentViewShadow: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var highConstraint: NSLayoutConstraint!
    @IBOutlet var collectionViewTabbar: UICollectionView!
    @IBOutlet var collectionViewData: UICollectionView!
    
    private var viewModel:ViewModel!
    private var lastContentOffset: CGFloat = 0.0
    
    private var lendingList: [LendingData] = [
     LendingData(name: "test1"),
     LendingData(name: "test2"),
     LendingData(name: "test3"),
     LendingData(name: "test4"),
     LendingData(name: "test5"),
     LendingData(name: "test6")
    ]
    
    private var borrowingList: [BorrowingData] = [
     BorrowingData(name: "test"),
     BorrowingData(name: "test2"),BorrowingData(name: "test3"),BorrowingData(name: "test4"),BorrowingData(name: "test5"),BorrowingData(name: "test6"),BorrowingData(name: "test7"),BorrowingData(name: "test8"),BorrowingData(name: "test9"),BorrowingData(name: "test10"),BorrowingData(name: "test11"),BorrowingData(name: "test12"),BorrowingData(name: "test13"),BorrowingData(name: "test14"),BorrowingData(name: "test15"),BorrowingData(name: "test16"),BorrowingData(name: "test17"),BorrowingData(name: "test18"),
    ]
    
    private var reviewList: [ReviewData] = [
        ReviewData(reviewString: "testRev1"),
        ReviewData(reviewString: "testRev2"),
        ReviewData(reviewString: "testRev3"),
        ReviewData(reviewString: "testRev4"),
        ReviewData(reviewString: "testRev5"),
        ReviewData(reviewString: "testRev6"),
        ReviewData(reviewString: "testRev7"),
        ReviewData(reviewString: "testRev8"),
        ReviewData(reviewString: "testRev9"),
        ReviewData(reviewString: "testRev10"),
        ReviewData(reviewString: "testRev11"),
        ReviewData(reviewString: "testRev12"),
        ReviewData(reviewString: "testRev13"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel(lending: lendingList, borrows: borrowingList, reviews: reviewList)
        
        self.collectionViewTabbar.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        
        let columnLayout = ColumnFlowLayout(cellsPerRow: 2, minimumInteritemSpacing: 10, minimumLineSpacing: 19)
        
        collectionViewData?.collectionViewLayout = columnLayout
        collectionViewData?.contentInsetAdjustmentBehavior = .always
        
        
        contentView.layer.cornerRadius = 20

        contentViewShadow.layer.cornerRadius = 20
        contentViewShadow.layer.shadowOffset = CGSize(width: 0, height: 3)
        contentViewShadow.layer.shadowColor = UIColor.black.cgColor
        contentViewShadow.layer.shadowOpacity = 0.5
        contentViewShadow.layer.shadowRadius = 4


    }
    
}

extension ViewController2: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewTabbar) {
            return viewModel.numberOfTabs()
        }
        
        if let selectedIndex = collectionViewTabbar.indexPathsForSelectedItems?.first?.row, let listType = ListType(rawValue: selectedIndex) {
            return self.viewModel.numberOfRows(for: listType)
        }
        return 0
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 180, height: 280)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewTabbar.dequeueReusableCell(withReuseIdentifier: "tabcell", for: indexPath) as! TabCollectionViewCell
        
        if (indexPath.row == 0) {
            cell.textLabel.text = String(describing: self.viewModel.tab(at: 0)).capitalized
            cell.selectedBorder.backgroundColor = UIColor.black
        } else if (indexPath.row == 1) {
            cell.textLabel.text = String(describing: self.viewModel.tab(at: 1)).capitalized
        } else {
            cell.textLabel.text = String(describing: self.viewModel.tab(at: 2)).capitalized
        }
        
        if (collectionView == collectionViewData) {
            
            if let selectedIndex = collectionViewTabbar.indexPathsForSelectedItems?.first?.row, let listType = ListType(rawValue: selectedIndex) {
                let cell2 = collectionViewData.dequeueReusableCell(withReuseIdentifier: "itemcell", for: indexPath) as! DataItemCollectionViewCell
                
                
                if(listType == .borrows) {
                    if let item = self.viewModel.element(at: indexPath.row, for: listType) as? BorrowingData {
                        cell2.itemName?.text = item.name
                    }
                    
                } else if (listType == .lendings) {
                    if let item = self.viewModel.element(at: indexPath.row, for: listType) as? LendingData {
                        cell2.itemName?.text = item.name
                    }
                }
                else {
                    if let item = self.viewModel.element(at: indexPath.row, for: listType) as? ReviewData {
                        cell2.itemName?.text = item.reviewString
                    }
                }
                
                return cell2
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == collectionViewTabbar) {
            collectionViewTabbar.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            if let cell = collectionView.cellForItem(at: indexPath) as? TabCollectionViewCell {
                cell.selectedBorder.backgroundColor = UIColor.black
            }
            self.collectionViewData.reloadData()

            if(indexPath.row == 0 || indexPath.row == 1) {
                let columnLayout = ColumnFlowLayout(cellsPerRow: 2, minimumInteritemSpacing: 10, minimumLineSpacing: 19)
                
                collectionViewData?.collectionViewLayout = columnLayout
                collectionViewData?.contentInsetAdjustmentBehavior = .always
                
            } else {
                let columnLayout = ColumnFlowLayout(cellsPerRow: 1, minimumInteritemSpacing: 10, minimumLineSpacing: 19)
                
                collectionViewData?.collectionViewLayout = columnLayout
                collectionViewData?.contentInsetAdjustmentBehavior = .always
            }
        }
        
        if (collectionView == collectionViewData) {
            let cell = collectionView.cellForItem(at: indexPath)
            UIView.animate(withDuration: 0.1,
                             animations: {
                              //Fade-out
                              cell?.alpha = 0.5
              }) { (completed) in
                  UIView.animate(withDuration: 0.1,
                                 animations: {
                                  //Fade-out
                                  cell?.alpha = 1
                  })
              }
        }
    
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if (collectionView == collectionViewTabbar) {
            if let cell = collectionView.cellForItem(at: indexPath) as? TabCollectionViewCell {
                cell.selectedBorder.backgroundColor = UIColor.clear
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionViewData {
            
            var lastContentOffset: CGFloat = 0.0
            let maxHeaderHeight: CGFloat = 300.0
            if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                       //Scrolled to bottom
                UIView.animate(withDuration: 0.3, animations: {
                    self.headerView.alpha = 0
                }) {_ in
                           self.highConstraint.constant = 0.0
                           self.view.layoutIfNeeded()
                            
                       }
                   }
                   else if (scrollView.contentOffset.y < self.lastContentOffset || scrollView.contentOffset.y <= 0) && (self.highConstraint.constant != maxHeaderHeight)  {
                       //Scrolling up, scrolled to top'
                       UIView.animate(withDuration: 0.3) {
                           self.highConstraint.constant = maxHeaderHeight
                           self.view.layoutIfNeeded()
                           self.headerView.alpha = 1.0
                       }
                   }
                   else if (scrollView.contentOffset.y > self.lastContentOffset) && self.highConstraint.constant != 0.0 {
                       //Scrolling down
                       UIView.animate(withDuration: 0.3) {
                           self.highConstraint.constant = 0.0
                           self.view.layoutIfNeeded()
                           self.headerView.alpha = 0.0
                       }
                   }
                   self.lastContentOffset = scrollView.contentOffset.y
               }
        }
    }






