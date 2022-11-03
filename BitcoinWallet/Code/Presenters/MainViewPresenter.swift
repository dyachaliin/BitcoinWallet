//
//  MainViewPresenter.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 02.11.2022.
//

import Foundation

protocol MainViewDelegate: NSObjectProtocol {
    func updateUI(with exchange: Double)
}

class MainViewPresenter {
    
    weak private var mainViewDelegate: MainViewDelegate?
    
    func setViewDelegate(mainViewDelegate: MainViewDelegate?){
        self.mainViewDelegate = mainViewDelegate
    }
    
    func obtainExchangeResults() {
        NetworkManager.obtainExchangeResults {[weak self] (result) in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    if let amount = result?.currency.usd.rateFloat {
                        self?.mainViewDelegate?.updateUI(with: amount)
                        //                        self?.mainView.updateLabel(with: amount)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(forName: .newExchangeFetched, object: nil, queue: nil) { [weak self] (notification) in
            if let userInfo = notification.userInfo,
               let result = userInfo[Constants.exchange] as? Result {
                self?.mainViewDelegate?.updateUI(with: result.currency.usd.rateFloat)
            }
        }
    }
}


