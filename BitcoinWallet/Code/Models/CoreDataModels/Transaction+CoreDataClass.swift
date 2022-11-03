//
//  Transaction+CoreDataClass.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 01.11.2022.
//
//

import Foundation
import CoreData


enum Category: String, CaseIterable {
    case groceries
    case taxi
    case electronics
    case restaurant
    case other
    case none
    
    var displayName: String {
        return rawValue.capitalized
    }
}

public class Transaction: NSManagedObject {
    static let name = String(describing: Transaction.self)
    
    var categoryEnum: Category {
        get { return Category.init(rawValue: category ?? "none") ?? .none }
        set { category = newValue.rawValue }
    }
}
