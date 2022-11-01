//
//  Balance+CoreDataProperties.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 01.11.2022.
//
//

import Foundation
import CoreData


extension Balance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Balance> {
        return NSFetchRequest<Balance>(entityName: "Balance")
    }

    @NSManaged public var amount: Double

}

extension Balance : Identifiable {

}
