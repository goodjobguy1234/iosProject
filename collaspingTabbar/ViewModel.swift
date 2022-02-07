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

enum ItemStatus {
    case unavaliable, avaliable
}

struct LendingData: ProfileData {
    var name: String
    var pricePerMin: Int
    var status: ItemStatus
    var owner: String
    var quanlity: String
}

struct BorrowingData: ProfileData {
    var name: String
    var pricePerMin: Int
    var owner: String
    var quanlity: String
}

struct ReviewData: ProfileData {
    var reviewString: String
}

protocol ProfileData {
    
}

class ViewModel {
    let tabs: [ListType] = [.lendings, .borrows, .reviews]
    var lendingList: [LendingData]!
    var borrowList: [BorrowingData]!
    var reviewList: [ReviewData]!
    
    init(lending: [LendingData] = [], borrows: [BorrowingData] = [], reviews: [ReviewData] = []) {
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
       case .lendings: return lendingList[index] as! ProfileData
       case .borrows: return borrowList[index] as! ProfileData
       case .reviews: return reviewList[index] as! ProfileData
       }
   }
}
