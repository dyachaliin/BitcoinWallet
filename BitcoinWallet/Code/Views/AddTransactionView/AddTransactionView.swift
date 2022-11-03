//
//  AddTransactionView.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 31.10.2022.
//

import Foundation
import UIKit

final class AddTransactionView: UIView {
    
    //MARK: UI elements
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.text = "Add amount and select transaction category"
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "Inter-Regular", size: 20)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    private lazy var countTextField: UITextField = {
        let countTextField = UITextField()
        countTextField.translatesAutoresizingMaskIntoConstraints = false
        countTextField.backgroundColor = .white
        countTextField.layer.cornerRadius = 10
        countTextField.textColor = .black
        countTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        countTextField.keyboardType = .decimalPad
        return countTextField
    }()
    
    private lazy var categoryButton: UIButton = {
        let categoryButton = UIButton()
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        categoryButton.setBackgroundImage(UIImage(named: "categoryIcon"), for: .normal)
        return categoryButton
    }()
    
    private lazy var addTransactionButton: UIButton = {
        let addTransactionButton = UIButton()
        addTransactionButton.translatesAutoresizingMaskIntoConstraints = false
        addTransactionButton.setTitle("Add", for: .normal)
        addTransactionButton.setTitleColor(.blue, for: .normal)
        addTransactionButton.backgroundColor = .white
        addTransactionButton.layer.cornerRadius = 15
        addTransactionButton.titleLabel?.font = UIFont(name: "Inter-Bold", size: 15)
        return addTransactionButton
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countTextField, categoryButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.alignment = .center
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
        addSubview(titleLabel)
        addSubview(stackView)
        addSubview(addTransactionButton)
        addConstraints()
    }
    
    func addTransactionButtonTarget(_ target: Any?, action: Selector) {
        addTransactionButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func getTextFieldText() -> String {
        guard let text = countTextField.text else { return "" }
        return text
    }
    
    func addMenuToCategory(menu: UIMenu) {
        categoryButton.menu = menu
        categoryButton.showsMenuAsPrimaryAction = true
    }
    
    //MARK: Constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        let guide = self.safeAreaLayoutGuide
        constraints.append(titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 150))
        constraints.append(titleLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor))
        constraints.append(titleLabel.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(titleLabel.widthAnchor.constraint(equalToConstant: 250))
        
        constraints.append(countTextField.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(countTextField.widthAnchor.constraint(equalToConstant: 150))
        
        constraints.append(categoryButton.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(categoryButton.widthAnchor.constraint(equalToConstant: 30))
        
        constraints.append(stackView.centerXAnchor.constraint(equalTo: guide.centerXAnchor))
        constraints.append(stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                          constant: 20))
        
        constraints.append(addTransactionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                                                     constant: 20))
        constraints.append(addTransactionButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor))
        constraints.append(addTransactionButton.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(addTransactionButton.widthAnchor.constraint(equalTo: stackView.widthAnchor,
                                                                       constant: -60))
        
        NSLayoutConstraint.activate(constraints)
    }
}
