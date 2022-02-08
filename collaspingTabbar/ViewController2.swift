//
//  ViewController.swift
//  collaspingTabbar
//
//  Created by macbook on 1/2/2565 BE.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet var writeReviewView: UIView!
    @IBOutlet var reviewTableView: UITableView!
    @IBOutlet var distributeUIView: UIView!
    @IBOutlet var contentViewShadow: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var headerView: ProfileHeader!
    @IBOutlet var highConstraint: NSLayoutConstraint!
    @IBOutlet var collectionViewTabbar: UICollectionView!
    @IBOutlet var collectionViewData: UICollectionView!
    
    private var viewModel:ViewModel!
    private var lastContentOffset: CGFloat = 0.0
    
    private var lendingList: [LendingData] = [
        LendingData(name: "test1", pricePerMin: 300, status: .unavaliable, owner: "Thitare Nimanong", quanlity: "Fair"),
     LendingData(name: "test2", pricePerMin: 100, status: .avaliable, owner: "Thitare Nimanong", quanlity: "Fair"),
     LendingData(name: "test3", pricePerMin: 400, status: .avaliable, owner: "Thitare Nimanong", quanlity: "Fair"),
     LendingData(name: "test4", pricePerMin: 3400, status: .unavaliable, owner: "Thitare Nimanong", quanlity: "Fair"),
     LendingData(name: "test5", pricePerMin: 250, status: .avaliable, owner: "Thitare Nimanong", quanlity: "Fair"),
     LendingData(name: "test6", pricePerMin: 200, status: .unavaliable, owner: "Thitare Nimanong", quanlity: "Fair")
    ]
    
    private var borrowingList: [BorrowingData] = [
     BorrowingData(name: "test1", pricePerMin: 100, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test2", pricePerMin: 200, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test3", pricePerMin: 300, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test4", pricePerMin: 400, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test5", pricePerMin: 500, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test6", pricePerMin: 150, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test7", pricePerMin: 160, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test8", pricePerMin: 190, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test9", pricePerMin: 210, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test10", pricePerMin: 250, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test11", pricePerMin: 340, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test12", pricePerMin: 300, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test13", pricePerMin: 260, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test14", pricePerMin: 250, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test15", pricePerMin: 280, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test16", pricePerMin: 350, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test17", pricePerMin: 380, owner: "Thitare Nimanong", quanlity: "Fair"),
     BorrowingData(name: "test18", pricePerMin: 410, owner: "Thitare Nimanong", quanlity: "Fair"),
    ]
    
    private var reviewList: [ReviewData] = [
        ReviewData(reviewString: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", reviewName: "bam"),
        ReviewData(reviewString: "testRev2", reviewName: "bam"),
        ReviewData(reviewString: "testRev3", reviewName: "bam"),
        ReviewData(reviewString: "testRev4", reviewName: "bam"),
        ReviewData(reviewString: "testRev5", reviewName: "bam"),
        ReviewData(reviewString: "testRev6", reviewName: "bam"),
        ReviewData(reviewString: "testRev7", reviewName: "bam"),
        ReviewData(reviewString: "testRev8", reviewName: "bam"),
        ReviewData(reviewString: "testRev9", reviewName: "bam"),
        ReviewData(reviewString: "testRev10", reviewName: "bam"),
        ReviewData(reviewString: "testRev11", reviewName: "bam"),
        ReviewData(reviewString: "testRev12", reviewName: "bam"),
        ReviewData(reviewString: "testRev13", reviewName: "bam"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeReviewView.isHidden = true
        reviewTableView.isHidden = true
        viewModel = ViewModel(lending: lendingList, borrows: borrowingList, reviews: reviewList)
        
        self.collectionViewTabbar.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
    
        writeReviewView.layer.cornerRadius = 4
        writeReviewView.layer.borderColor = UIColor.lightGray.cgColor
        writeReviewView.layer.borderWidth = 1.0
        
        distributeUIView.layer.cornerRadius = 16
        distributeUIView.layer.borderWidth = 1.0
        distributeUIView.layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.layer.cornerRadius = 20

        contentViewShadow.layer.cornerRadius = 20
        contentViewShadow.layer.shadowOffset = CGSize(width: 0, height: 3)
        contentViewShadow.layer.shadowColor = UIColor.black.cgColor
        contentViewShadow.layer.shadowOpacity = 0.5
        contentViewShadow.layer.shadowRadius = 4
        
        headerView.isUserInteractionEnabled = true
        headerView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:))))
        
        writeReviewView.isUserInteractionEnabled = true
        writeReviewView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onWriteReviewClicked(_gesture:))))
    }
    
    @objc private func onWriteReviewClicked (_gesture: UITapGestureRecognizer) {
        let view = _gesture.view
        // go to next page
        
        if let reviewViewController = storyboard?.instantiateViewController(withIdentifier: "reviewpage") as? ReviewViewController {
            reviewViewController.timeText = "13:00 p.m"
            reviewViewController.userImage = "john"
            reviewViewController.dateText = "24 September 2020"
            reviewViewController.userNameText = "Nathan Woah"
            self.present(reviewViewController, animated: true)
        }
    }
    
    @objc private func handlePanGesture (_ gesture : UIPanGestureRecognizer ) {
        let translation = gesture.translation(in: headerView)
       gesture.setTranslation(CGPoint(x: translation.x , y: 0.0), in:
                                headerView)
       if translation.y > 0 &&
            highConstraint.constant == 300.0 {
           return
        }
       if translation.y < 0 &&
            highConstraint.constant == 0.0 {
           return
       }
        if let cell = collectionViewData.visibleCells.first as?
               DataItemCollectionViewCell {
            collectionViewData.contentOffset.y =
                collectionViewData.contentOffset.y - translation.y
         }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 184, height: 261)
    }
    
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
                        cell2.itemOwner?.text = item.owner
                        cell2.itemPrice?.text = "฿\(item.pricePerMin)"
                        cell2.itemQuality?.text = item.quanlity
                        cell2.imageItem?.image = UIImage(named: item.imageName) // load image here
                        cell2.itemStatus?.isHidden = true
                    }
                    
                } else if (listType == .lendings) {

                    if let item = self.viewModel.element(at: indexPath.row, for: listType) as? LendingData {
                        cell2.itemName?.text = item.name
                        cell2.itemOwner?.text = item.owner
                        cell2.itemPrice?.text = "฿\(item.pricePerMin)"
                        cell2.itemQuality?.text = item.quanlity
                        cell2.imageItem?.image = UIImage(named: item.imageName)
                        if(item.status == .unavaliable) {
                            cell2.itemStatus.isHidden = false
                        } else {
                            cell2.itemStatus.isHidden = true
                        }
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
            
            if(indexPath.row == 2) {
                reviewTableView.isHidden = false
                collectionViewData?.isHidden = true
                writeReviewView?.isHidden = false
                self.reviewTableView.reloadData()
            } else {
                //load data again
                reviewTableView.isHidden = true
                collectionViewData.isHidden = false
                writeReviewView?.isHidden = true
                self.collectionViewData.reloadData()
                // back to the top item
                
    //            collectionViewData?.setContentOffset(.zero, animated: true)
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
        if scrollView == collectionViewData || scrollView == reviewTableView {
            
            var lastContentOffset: CGFloat = 0.0
            let maxHeaderHeight: CGFloat = 300.0
            var bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
            
            if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                       //Scrolled to bottom
                UIView.animate(withDuration: 0.3, animations: {
                    self.headerView.alpha = 0
                }) {_ in
                           self.highConstraint.constant = 0.0
                           self.view.layoutIfNeeded()
                            
                       }
                   }
                   else if (scrollView.contentOffset.y < lastContentOffset || scrollView.contentOffset.y <= 0) && (self.highConstraint.constant != maxHeaderHeight)  {
                       //Scrolling up, scrolled to top'
                       UIView.animate(withDuration: 0.3) {
                           self.highConstraint.constant = maxHeaderHeight
                           self.view.layoutIfNeeded()
                           self.headerView.alpha = 1.0
                       }
                   }
                   else if (scrollView.contentOffset.y > lastContentOffset) && highConstraint.constant != 0.0 {
                       //Scrolling down
                       UIView.animate(withDuration: 0.3) {
                           self.highConstraint.constant = 0.0
                           self.view.layoutIfNeeded()
                           self.headerView.alpha = 0.0
                       }
                   }
                   lastContentOffset = scrollView.contentOffset.y
               }
        }
    }


extension ViewController2: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let selectedIndex = collectionViewTabbar.indexPathsForSelectedItems?.first?.row, let listType = ListType(rawValue: selectedIndex) {
            return self.viewModel.numberOfRows(for: listType)

        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = reviewTableView.dequeueReusableCell(withIdentifier: "reviewcell", for: indexPath) as! ReviewTableViewCell
        if let item = self.viewModel.element(at: indexPath.row, for: .reviews) as? ReviewData {
            cell.reviewName.text = item.reviewName
            cell.reviewString.text = item.reviewString
            cell.reviewImage.image = UIImage(named: item.imageName)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    
}





