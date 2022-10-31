//
//  MainView.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 31.10.2022.
//

import Foundation
import UIKit

final class MainView: UIView {
    
    private lazy var exchangeRateLabel: UILabel = {
        let exchangeRateLabel = UILabel()
        exchangeRateLabel.translatesAutoresizingMaskIntoConstraints = false
        exchangeRateLabel.textAlignment = .center
        exchangeRateLabel.text = "I'm a test label"
//        exchangeRateLabel.backgroundColor = .red
        return exchangeRateLabel
    }()
    
    private lazy var currentBalanceTitle: UILabel = {
        let currentBalanceTitle = UILabel()
        currentBalanceTitle.translatesAutoresizingMaskIntoConstraints = false
        currentBalanceTitle.textAlignment = .center
        currentBalanceTitle.text = "Current Balance"
//        currentBalanceTitle.backgroundColor = .red
        return currentBalanceTitle
    }()
    
    private lazy var currentBalanceLabel: UILabel = {
        let currentBalanceLabel = UILabel()
        currentBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        currentBalanceLabel.textAlignment = .center
        currentBalanceLabel.text = "0.0"
//        currentBalanceLabel.backgroundColor = .green
        return currentBalanceLabel
    }()
    
    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = .green
        return addButton
    }()
    
    private lazy var addTransactionButton: UIButton = {
        let addTransactionButton = UIButton()
        addTransactionButton.translatesAutoresizingMaskIntoConstraints = false
        addTransactionButton.setTitle("Add Transaction", for: .normal)
        addTransactionButton.backgroundColor = .green
        return addTransactionButton
    }()
    
    private lazy var transactionsTableView: UITableView = {
        let transactionsTableView = UITableView()
        transactionsTableView.translatesAutoresizingMaskIntoConstraints = false
        return transactionsTableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addConstraints()
      }
      
      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        addConstraints()
      }
      
      private func setupView() {
        backgroundColor = .white
          addSubview(exchangeRateLabel)
          addSubview(currentBalanceTitle)
          addSubview(currentBalanceLabel)
          addSubview(addButton)
          addSubview(addTransactionButton)
          addSubview(transactionsTableView)
      }
    
    func addTransactionButtonTarget(_ target: Any?, action: Selector) {
        addTransactionButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()

        let guide = self.safeAreaLayoutGuide
        constraints.append(exchangeRateLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor,
                                                                       constant: -30))
        constraints.append(exchangeRateLabel.topAnchor.constraint(equalTo: guide.topAnchor,
                                                                  constant: 20))

        constraints.append(currentBalanceTitle.topAnchor.constraint(equalTo: exchangeRateLabel.bottomAnchor,
                                                                    constant: 20))
        constraints.append(currentBalanceTitle.leadingAnchor.constraint(equalTo: guide.leadingAnchor,
                                                                        constant: 50))
        
        constraints.append(currentBalanceLabel.topAnchor.constraint(equalTo: currentBalanceTitle.bottomAnchor,
                                                                    constant: 20))
        constraints.append(currentBalanceLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor,
                                                                        constant: 80))
        
        constraints.append(addButton.centerYAnchor.constraint(equalTo: currentBalanceLabel.centerYAnchor))
        constraints.append(addButton.leadingAnchor.constraint(equalTo: currentBalanceLabel.trailingAnchor,
                                                              constant: 30))
        
        constraints.append(addTransactionButton.topAnchor.constraint(equalTo: addButton.bottomAnchor,
                                                                     constant: 20))
        constraints.append(addTransactionButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor))
        
        constraints.append(transactionsTableView.topAnchor.constraint(equalTo: addTransactionButton.bottomAnchor, constant: 20))
        constraints.append(transactionsTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor))
        constraints.append(transactionsTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor))
        constraints.append(transactionsTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor))
                                              
        NSLayoutConstraint.activate(constraints)
    }
}
