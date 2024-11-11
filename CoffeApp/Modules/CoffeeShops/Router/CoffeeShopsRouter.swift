//
//  CoffeeShopsRouter.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 29.10.2024.
//

import Foundation
import UIKit

protocol CoffeeShopsRouterProtocol: AnyObject {
    static func createModule(globalRouter: GlobalRouterProtocol) -> UIViewController
    func navigateToMenu(locationId: Int)
    func navigateToLogin()
}

class CoffeeShopsRouter: CoffeeShopsRouterProtocol {
    weak var viewController: UIViewController?
    private var globalRouter: GlobalRouterProtocol?
    
    static func createModule(globalRouter: GlobalRouterProtocol) -> UIViewController {
        let view = CoffeeShopsViewController()
        let presenter = CoffeeShopsPresenter()
        let service = CoffeeShopsService()
        let interactor = CoffeeShopsInteractor(service: service)
        let router = CoffeeShopsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        router.globalRouter = globalRouter
        
        return view
    }
    
    func navigateToMenu(locationId: Int) {
        let menuViewController = MenuRouter.createModule(locationId: locationId)
        viewController?.navigationController?.pushViewController(menuViewController, animated: true)
    }

    func navigateToLogin() {
        globalRouter?.navigateToLogin()
    }
}
