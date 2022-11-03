//
//  SceneDelegate.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 30.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: MainViewController())
        self.window = window
        window.makeKeyAndVisible()
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as! AppDelegate).scheduleBackgroundExchangeFetch()
    }
}

