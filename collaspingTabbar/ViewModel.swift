//
//  ViewModel.swift
//  collaspingTabbar
//
//  Created by macbook on 1/2/2565 BE.
//

import Foundation

enum ListType: Int {
    case lendings, borrows, reviews
}

enum ProfileData {
    struct LendingData {
        var name: String
    }

    struct BorrowingData {
        var name: String
    }

    struct ReviewData {
        var reviewString: String
    }
    
    case lending(LendingData)
    case borrow(BorrowingData)
    case review(ReviewData)
}

class ViewModel {
    let tabs: [ListType] = [.lendings, .borrows, .reviews]
    var lendingList: [ProfileData]!
    var borrowList: [ProfileData]!
    var reviewList: [ProfileData]!
    
    init(lending: [ProfileData] = [], borrows: [ProfileData] = [], reviews: [ProfileData] = []) {
        lendingList = lending
        borrowList = borrows
        reviewList = reviews
    }
       
   func numberOfTabs() -> Int {
       return tabs.count
   }

   func tab(at index: Int) -> ListType {
       return tabs[index]
   }

   func numberOfRows(for listType: ListType) -> Int {
       switch listType {
       case .lendings: return lendingList.count
       case .borrows: return borrowList.count
       case .reviews: return reviewList.count
       }
   }

    func element(at index: Int, for listType: ListType) -> ProfileData {
       switch listType {
       case .lendings: return lendingList[index]
       case .borrows: return borrowList[index]
       case .reviews: return reviewList[index]
       }
   }
}
