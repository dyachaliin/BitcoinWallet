//
//  TransactionCell.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 01.11.2022.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    static let identifier = String(describing: TransactionCell.self)
    
    //MARK: UI elements
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont(name: "Inter-Medium", size: 15)
        dateLabel.textColor = .black
        return dateLabel
    }()
    
    private lazy var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.textAlignment = .center
        categoryLabel.font = UIFont(name: "Inter-Regular", size: 12)
        categoryLabel.textColor = .black
        return categoryLabel
    }()
    
    private lazy var amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont(name: "Inter-Regular", size: 15)
        amountLabel.textColor = .black
        return amountLabel
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, categoryLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(stackView)
        addSubview(amountLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(category: String, amount: Double, isReplenish: Bool, date: Date) {
        dateLabel.text = dateFormatter(date: date)
        categoryLabel.text = isReplenish ? "" : category
        amountLabel.text = isReplenish ? "+\(amount)" : "-\(amount)"
        amountLabel.textColor = isReplenish ? .green : .red
    }
    
    private func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
    
    //MARK: Constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        let guide = self.safeAreaLayoutGuide
        constraints.append(stackView.centerYAnchor.constraint(equalTo: guide.centerYAnchor))
        constraints.append(stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor,
                                                              constant: 30))
        
        constraints.append(amountLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor))
        constraints.append(amountLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
