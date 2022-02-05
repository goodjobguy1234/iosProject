//
//  ViewController.swift
//  collaspingTabbar
//
//  Created by macbook on 1/2/2565 BE.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet var highConstraint: NSLayoutConstraint!
    @IBOutlet var collectionViewTabbar: UICollectionView!
    @IBOutlet var collectionViewData: UICollectionView!
    
    private let viewModel = ViewModel()
    private var lastContentOffset: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewTabbar.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)

        
    }


}

extension ViewController2: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewTabbar) {
            return viewModel.numberOfTabs()
        }
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewTabbar.dequeueReusableCell(withReuseIdentifier: "tabcell", for: indexPath) as! TabCollectionViewCell
        
        if (indexPath.row == 0) {
            cell.textLabel.text = String(describing: self.viewModel.tab(at: 0)).capitalized
        } else if (indexPath.row == 1) {
            cell.textLabel.text = String(describing: self.viewModel.tab(at: 1)).capitalized
        } else {
            cell.textLabel.text = String(describing: self.viewModel.tab(at: 2)).capitalized
        }
        
        if (collectionView == collectionViewData) {
            let cell2 = collectionViewData.dequeueReusableCell(withReuseIdentifier: "itemcell", for: indexPath) as! DataItemCollectionViewCell
            
            return cell2
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == collectionViewTabbar) {
            collectionViewTabbar.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            if let cell = collectionViewTabbar.cellForItem(at: indexPath) as? TabCollectionViewCell {
                cell.selectedBorder.backgroundColor = UIColor.blue
            }
            
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionViewData {
            
            var lastContentOffset: CGFloat = 0.0
            let maxHeaderHeight: CGFloat = 300.0
            if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                       //Scrolled to bottom
                       UIView.animate(withDuration: 0.3) {
                           self.highConstraint.constant = 0.0
                           self.view.layoutIfNeeded()
                       }
                   }
                   else if (scrollView.contentOffset.y < self.lastContentOffset || scrollView.contentOffset.y <= 0) && (self.highConstraint.constant != maxHeaderHeight)  {
                       //Scrolling up, scrolled to top
                       UIView.animate(withDuration: 0.3) {
                           self.highConstraint.constant = maxHeaderHeight
                           self.view.layoutIfNeeded()
                       }
                   }
                   else if (scrollView.contentOffset.y > self.lastContentOffset) && self.highConstraint.constant != 0.0 {
                       //Scrolling down
                       UIView.animate(withDuration: 0.3) {
                           self.highConstraint.constant = 0.0
                           self.view.layoutIfNeeded()
                       }
                   }
                   self.lastContentOffset = scrollView.contentOffset.y
               }
        }
    }





