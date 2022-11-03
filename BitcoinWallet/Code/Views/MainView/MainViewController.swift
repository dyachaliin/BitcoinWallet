//
//  MainViewController.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 30.10.2022.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
  
    private let mainView = MainView()
    private let balance = DataStoreManager.shared.obtainBalance()
    private let presenter: MainViewPresenter = MainViewPresenter()
    
    private var fetchedResultsController: NSFetchedResultsController<Transaction>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(mainViewDelegate: self)
        mainView.tableViewDelegate = self
        mainView.tableViewDataSource = self
        mainView.tableViewRegisterClass(cellClass: TransactionCell.self, forCellReuseIdentifier: TransactionCell.identifier)
        
        setupButtons()
        mainView.updateBalance(with: balance.amount)
        
        presenter.registerForNotifications()
        presenter.obtainExchangeResults()

        balance.addObserver(self, forKeyPath: #keyPath(Balance.amount), options: .new, context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        loadSavedData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard keyPath == #keyPath(Transaction.amount) else { return }
        mainView.updateBalance(with: balance.amount)
    }
    
    private func setupButtons() {
        mainView.addTransactionButtonTarget(self, action: #selector(toTransactionScreen))
        mainView.addButtonTarget(self, action: #selector(presentPopUp))
    }
    
    @objc func toTransactionScreen() {
        let vc = AddTransactionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func presentPopUp() {
        let alertController = UIAlertController(title: "Replenish the balance", message: "Please, enter the amount you want to add", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter amount"
            textField.keyboardType = .decimalPad
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let inputName = alertController.textFields![0].text, let amount = Double(inputName.replacingOccurrences(of: ",", with: ".")) else { return }
            
            DataStoreManager.shared.addTransaction(isReplenish: true, amount: amount, category: .none)
            self.loadSavedData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func loadSavedData() {
        if fetchedResultsController == nil {
            let request = Transaction.fetchRequest()
            let sort = NSSortDescriptor(key: Constants.sortKey, ascending: false)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: DataStoreManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
        }

        do {
            try fetchedResultsController.performFetch()
            mainView.reloadTableView()
        } catch {
            print("Fetch failed")
        }
    }
}

extension MainViewController: MainViewDelegate {
    func updateUI(with exchange: Double) {
        mainView.updateLabel(with: exchange)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = mainView.tableViewDequeueReusableCellWithIdentifier(identifier: TransactionCell.identifier) as? TransactionCell {
            let transaction = fetchedResultsController.object(at: indexPath)
            cell.set(category: transaction.categoryEnum.rawValue, amount: transaction.amount,
                     isReplenish: transaction.isReplenish, date: transaction.dateCreated ?? Date())
            cell.selectionStyle = .none
            cell.backgroundColor = .white
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
}

extension MainViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let indexPath = indexPath else { return }
            mainView.insertRows(at: indexPath)
        default:
            break
        }
    }
}
