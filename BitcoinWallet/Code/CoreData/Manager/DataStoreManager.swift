//
//  DataStoreManager.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 01.11.2022.
//

import Foundation
import CoreData

class DataStoreManager {
    
    static let shared = DataStoreManager()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BitcoinWallet")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func obtainBalance() -> Balance {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Balance.name)
        
        if let balance = try? viewContext.fetch(fetchRequest) as? [Balance], balance.count == 1 {
            return balance.first!
        } else {
            let balance = Balance(context: viewContext)
        
            do {
                try viewContext.save()
            } catch let error {
                print("error: \(error.localizedDescription)")
            }
            
            return balance
        }
    }
    
    func updateBalance(with amount: Double, isReplenish: Bool) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Balance.name)
        
        if let balance = try? viewContext.fetch(fetchRequest) as? [Balance] {
            guard let balance = balance.first else { return }
            
            if isReplenish {
                balance.amount += amount
            } else {
                balance.amount -= amount
            }
            
            do {
                try viewContext.save()
            } catch let error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    func addTransaction(isReplenish: Bool, amount: Double, category: Category, completion: @escaping () -> Void) {
        let transaction = Transaction(context: viewContext)
        transaction.amount = amount
        transaction.isReplenish = isReplenish
        transaction.categoryEnum = category
        transaction.dateCreated = Date()
        
        do {
            try viewContext.save()
        } catch let error {
            print("error: \(error.localizedDescription)")
        }
        
        updateBalance(with: amount, isReplenish: isReplenish)
        completion()
    }
    
//    func getBalance() -> [Balance]? {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Balance.name)
//
//        if let balance = try? viewContext.fetch(fetchRequest) as? [Balance] {
//            return balance
//        }
//
//        return nil
//    }
    
    private init() {}
}
