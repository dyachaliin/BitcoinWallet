//
//  AddTransactionViewController.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 31.10.2022.
//

import UIKit

class AddTransactionViewController: UIViewController {
    
    private let addTransactionView = AddTransactionView()
    private let balance = DataStoreManager.shared.obtainBalance()
    private var category: Category = .none
    
    override func loadView() {
        self.view = addTransactionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTransactionView.addTransactionButtonTarget(self, action: #selector(addTransaction))
        makeCategoryMenu()
    }
    
    @objc func addTransaction() {
        let textFieldAmount = addTransactionView.getTextFieldText()
        guard !textFieldAmount.isEmpty, let amount = Double(textFieldAmount.replacingOccurrences(of: ",", with: ".")), category != .none else { return }
        
        if balance.amount < amount {
            showAlert()
        } else {
            DataStoreManager.shared.addTransaction(isReplenish: false, amount: amount, category: category)
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Sorry, you don't have enough money", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Category Menu
    private func makeCategoryMenu() {
        
        let groceries = makeAction(category: .groceries, imageName: "cart") {  self.category = .groceries }
        let taxi = makeAction(category: .taxi, imageName: "car") {  self.category = .taxi }
        let electronics = makeAction(category: .electronics, imageName: "iphone") {  self.category = .electronics }
        let restaurant = makeAction(category: .restaurant, imageName: "wineglass") {  self.category = .restaurant }
        let other = makeAction(category: .other, imageName: "heart") {  self.category = .other }
        
        let menu = UIMenu(options: .displayInline, children: [groceries, taxi, electronics, restaurant, other])
        
        addTransactionView.addMenuToCategory(menu: menu)
    }
    
    func makeAction(category: Category, imageName: String, action: @escaping () -> Void) -> UIAction {
        return UIAction(title: category.displayName, image: UIImage(systemName: imageName)) { _ in
            action()
        }
    }
    
}
