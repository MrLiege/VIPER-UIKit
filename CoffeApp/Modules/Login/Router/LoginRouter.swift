//
//  LoginRouter.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 29.10.2024.
//

import UIKit

protocol LoginRouterProtocol: AnyObject {
    static func createModule(globalRouter: GlobalRouterProtocol) -> UIViewController
    func navigateToCoffeeShops()
}

class LoginRouter: LoginRouterProtocol {
    weak var viewController: UIViewController?
    private var globalRouter: GlobalRouterProtocol?

    static func createModule(globalRouter: GlobalRouterProtocol) -> UIViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        router.globalRouter = globalRouter
        
        return view
    }

    func navigateToCoffeeShops() {
        globalRouter?.navigateToCoffeeShops()
    }
}
