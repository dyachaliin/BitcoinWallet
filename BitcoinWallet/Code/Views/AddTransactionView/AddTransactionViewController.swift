//
//  AddTransactionViewController.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 31.10.2022.
//

import UIKit

class AddTransactionViewController: UIViewController {
    
    let addTransactionView = AddTransactionView()
    
    override func loadView() {
        self.view = addTransactionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
