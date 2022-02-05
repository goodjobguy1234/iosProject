//
//  ViewController.swift
//  collaspingTabbar
//
//  Created by macbook on 1/2/2565 BE.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collasingViewHightConstraint: NSLayoutConstraint!
    @IBOutlet var collectionViewTabbar: UICollectionView!
    @IBOutlet var collectionViewData: UICollectionView!
    
    private let viewModel = ViewModel()
    private var lastContentOffset: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewTabbar.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
//        let myView = UIView(frame: CGRect(x: 10, y: 10, width: 200, height: 200))
//        view.addSubview(myView)
//
        
    }


}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewTabbar) {
            return 3
        }
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewTabbar.dequeueReusableCell(withReuseIdentifier: "tabcell", for: indexPath) as! TabCollectionViewCell
        cell.backgroundColor = UIColor.red
        
        if (collectionView == collectionViewData) {
            let cell2 = collectionViewData.dequeueReusableCell(withReuseIdentifier: "itemcell", for: indexPath) as! DataItemCollectionViewCell
            return cell2
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
//
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionViewData {
                   if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                       //Scrolled to bottom
                       UIView.animate(withDuration: 0.3) {
                           self.collasingViewHightConstraint.constant = 0.0
                           self.view.layoutIfNeeded()
                       }
                   }
                   else if (scrollView.contentOffset.y < self.lastContentOffset || scrollView.contentOffset.y <= 0) && (self.collasingViewHightConstraint.constant != 300.0)  {
                       //Scrolling up, scrolled to top
                       UIView.animate(withDuration: 0.3) {
                           self.collasingViewHightConstraint.constant = 300.0
                           self.view.layoutIfNeeded()
                       }
                   }
                   else if (scrollView.contentOffset.y > self.lastContentOffset) && self.collasingViewHightConstraint.constant != 0.0 {
                       //Scrolling down
                       UIView.animate(withDuration: 0.3) {
                           self.collasingViewHightConstraint.constant = 0.0
                           self.view.layoutIfNeeded()
                       }
                   }
                   self.lastContentOffset = scrollView.contentOffset.y
            
        }
    }
}




