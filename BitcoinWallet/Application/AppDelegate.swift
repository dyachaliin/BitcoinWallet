//
//  AppDelegate.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 30.10.2022.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        window?.makeKeyAndVisible()
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: Constants.backgroundId,
                                        using: nil) { (task) in
            self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
        }
        
        return true
    }
    
    func scheduleBackgroundExchangeFetch() {
        let fetchExchange = BGAppRefreshTaskRequest(identifier: Constants.backgroundId)
        fetchExchange.earliestBeginDate = Date(timeIntervalSinceNow: 3600)
        do {
            try BGTaskScheduler.shared.submit(fetchExchange)
            print("Submitted task request")
        } catch {
            print("Unable to submit task: \(error.localizedDescription)")
        }
    }
    
    func handleAppRefreshTask(task: BGAppRefreshTask) {
        
        task.expirationHandler = {
            NetworkManager.urlSession.invalidateAndCancel()
            task.setTaskCompleted(success: false)
        }
        
        do {
            try NetworkManager.obtainExchangeResults { (results) in
                switch results {
                case .success(let result):
                    NotificationCenter.default.post(name: .newExchangeFetched,
                                                    object: self,
                                                    userInfo: [Constants.exchange : result])
                    task.setTaskCompleted(success: true)
                case .failure(let error):
                    print(error.localizedDescription)
                    task.setTaskCompleted(success: true)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        scheduleBackgroundExchangeFetch()
    }
}

