//
//  Transaction+CoreDataProperties.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 01.11.2022.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var dateCreated: Date?
    @NSManaged public var amount: Double
    @NSManaged public var isReplenish: Bool
    @NSManaged public var category: String?

}

extension Transaction : Identifiable {

}
