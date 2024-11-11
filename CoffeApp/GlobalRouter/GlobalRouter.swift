//
//  GlobalRouter.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 29.10.2024.
//

import UIKit
import Foundation

protocol GlobalRouterProtocol: AnyObject {
    func start()
    func navigateToLogin()
    func navigateToRegistration()
    func navigateToCoffeeShops()
}

class GlobalRouter: GlobalRouterProtocol {
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if let token = UserStorage.shared.token, !token.isEmpty {
            navigateToCoffeeShops()
        } else if UserStorage.shared.isFirstLaunch {
            navigateToRegistration()
        } else {
            navigateToLogin()
        }
    }
    
    func navigateToLogin() {
        let loginViewController = LoginRouter.createModule(globalRouter: self)
        setRootViewController(loginViewController)
    }
    
    func navigateToRegistration() {
        let registrationViewController = RegistrationRouter.createModule(globalRouter: self)
        setRootViewController(registrationViewController)
    }
    
    func navigateToCoffeeShops() {
        let coffeeShopsViewController = CoffeeShopsRouter.createModule(globalRouter: self)
        setRootViewController(coffeeShopsViewController)
    }
    
    private func setRootViewController(_ vc: UIViewController) {
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft],
                          animations: nil,
                          completion: nil)
    }
}
