//
//  MainView.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 31.10.2022.
//

import Foundation
import UIKit

final class MainView: UIView {
    
    //MARK: UI elements
    private lazy var exchangeRateLabel: UILabel = {
        let exchangeRateLabel = UILabel()
        exchangeRateLabel.translatesAutoresizingMaskIntoConstraints = false
        exchangeRateLabel.textAlignment = .center
        exchangeRateLabel.text = "I'm a test label"
        exchangeRateLabel.font = UIFont(name: "Inter-Regular", size: 15)
        exchangeRateLabel.textColor = .white
        return exchangeRateLabel
    }()
    
    private lazy var currentBalanceTitle: UILabel = {
        let currentBalanceTitle = UILabel()
        currentBalanceTitle.translatesAutoresizingMaskIntoConstraints = false
        currentBalanceTitle.textAlignment = .center
        currentBalanceTitle.text = "Current Balance"
        currentBalanceTitle.font = UIFont(name: "Inter-Medium", size: 25)
        currentBalanceTitle.textColor = .white
        return currentBalanceTitle
    }()
    
    private lazy var currentBalanceLabel: UILabel = {
        let currentBalanceLabel = UILabel()
        currentBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        currentBalanceLabel.textAlignment = .center
        currentBalanceLabel.text = "0.0"
        currentBalanceLabel.font = UIFont(name: "Inter-Regular", size: 20)
        currentBalanceLabel.textColor = .white
        return currentBalanceLabel
    }()
    
    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setBackgroundImage(UIImage(named: "addIcon"), for: .normal)
        return addButton
    }()
    
    private lazy var addTransactionButton: UIButton = {
        let addTransactionButton = UIButton()
        addTransactionButton.translatesAutoresizingMaskIntoConstraints = false
        addTransactionButton.setTitle("Add Transaction", for: .normal)
        addTransactionButton.titleLabel?.font = UIFont(name: "Inter-Bold", size: 15)
        addTransactionButton.setTitleColor(.blue, for: .normal)
        addTransactionButton.backgroundColor = .white
        addTransactionButton.layer.cornerRadius = 15
        return addTransactionButton
    }()
    
    private lazy var transactionsTableView: UITableView = {
        let transactionsTableView = UITableView()
        transactionsTableView.translatesAutoresizingMaskIntoConstraints = false
        transactionsTableView.clipsToBounds = true
        transactionsTableView.layer.cornerRadius = 30
        transactionsTableView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        return transactionsTableView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currentBalanceLabel, addButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(patternImage: UIImage(named: "mainBackground.jpg")!)
        addSubview(exchangeRateLabel)
        addSubview(currentBalanceTitle)
        addSubview(stackView)
        addSubview(addTransactionButton)
        addSubview(transactionsTableView)
        addConstraints()
    }
    
    func updateBalance(with amount: Double) {
        currentBalanceLabel.text = String(amount)
    }
    
    func addTransactionButtonTarget(_ target: Any?, action: Selector) {
        addTransactionButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addButtonTarget(_ target: Any?, action: Selector) {
        addButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    //MARK: TableView setup
    weak var tableViewDelegate: UITableViewDelegate? {
        get {
            return transactionsTableView.delegate
        }
        set {
            transactionsTableView.delegate = newValue
        }
    }
    
    
    weak var tableViewDataSource: UITableViewDataSource? {
        get {
            return transactionsTableView.dataSource
        }
        set {
            transactionsTableView.dataSource = newValue
        }
    }
    
    func tableViewRegisterClass(cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        transactionsTableView.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func tableViewDequeueReusableCellWithIdentifier(identifier: String) -> UITableViewCell? {
        return transactionsTableView.dequeueReusableCell(withIdentifier: identifier)
    }
    
    func reloadTableView() {
        transactionsTableView.reloadData()
    }
    
    func insertRows(at path: IndexPath) {
        transactionsTableView.insertRows(at: [path], with: .automatic)
    }
    
    //MARK: Constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        let guide = self.safeAreaLayoutGuide
        constraints.append(exchangeRateLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 30))
        constraints.append(exchangeRateLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor,
                                                                       constant: -30))
        
        constraints.append(currentBalanceTitle.topAnchor.constraint(equalTo: exchangeRateLabel.bottomAnchor,
                                                                    constant: 40))
        constraints.append(currentBalanceTitle.centerXAnchor.constraint(equalTo: guide.centerXAnchor))
        
        constraints.append(addButton.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(addButton.widthAnchor.constraint(equalToConstant: 40))
        
        constraints.append(stackView.topAnchor.constraint(equalTo: currentBalanceTitle.bottomAnchor,
                                                          constant: 20))
        constraints.append(stackView.centerXAnchor.constraint(equalTo: guide.centerXAnchor))
        
        constraints.append(addTransactionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                                                     constant: 20))
        constraints.append(addTransactionButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor))
        constraints.append(addTransactionButton.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(addTransactionButton.widthAnchor.constraint(equalToConstant: 150))
        
        constraints.append(transactionsTableView.topAnchor.constraint(equalTo: addTransactionButton.bottomAnchor,
                                                                      constant: 40))
        constraints.append(transactionsTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor))
        constraints.append(transactionsTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor))
        constraints.append(transactionsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}
