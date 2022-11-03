//
//  MainViewPresenter.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 02.11.2022.
//

import Foundation

protocol MainViewDelegate: NSObjectProtocol {
//    func togglePlayPauseBtn()
}

class MainViewPresenter {
    weak private var mainViewDelegate: MainViewDelegate?
    
//    let networkManager = NetworkManager()
    
    func setViewDelegate(mainViewDelegate: MainViewDelegate?){
        self.mainViewDelegate = mainViewDelegate
    }
    
//    func getResults() {
//        networkManager.obtainExchangeResults()
//    }
}


