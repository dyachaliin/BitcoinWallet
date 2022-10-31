//
//  AddTransactionView.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 31.10.2022.
//

import Foundation
import UIKit

final class AddTransactionView: UIView {
    
    private lazy var countTextField: UITextField = {
        let countTextField = UITextField()
        countTextField.translatesAutoresizingMaskIntoConstraints = false
        countTextField.backgroundColor = .red
        return countTextField
    }()
    
    private lazy var categoryButton: UIButton = {
        let categoryButton = UIButton()
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        categoryButton.setTitle("Category", for: .normal)
        categoryButton.backgroundColor = .green
        return categoryButton
    }()
    
    private lazy var addTransactionButton: UIButton = {
        let addTransactionButton = UIButton()
        addTransactionButton.translatesAutoresizingMaskIntoConstraints = false
        addTransactionButton.setTitle("Add Transaction", for: .normal)
        addTransactionButton.backgroundColor = .green
        return addTransactionButton
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countTextField, categoryButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
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
          addSubview(stackView)
          addSubview(addTransactionButton)
      }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()

        let guide = self.safeAreaLayoutGuide
        constraints.append(countTextField.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(countTextField.widthAnchor.constraint(equalToConstant: 100))
        
        constraints.append(stackView.centerXAnchor.constraint(equalTo: guide.centerXAnchor))
        constraints.append(stackView.topAnchor.constraint(equalTo: guide.topAnchor,
                                                                  constant: 150))

        constraints.append(addTransactionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                                                    constant: 20))
        constraints.append(addTransactionButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}
