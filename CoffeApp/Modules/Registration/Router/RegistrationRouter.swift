//
//  RegistrationRouter.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 06.11.2024.
//

import UIKit

protocol RegistrationRouterProtocol: AnyObject {
    static func createModule(globalRouter: GlobalRouterProtocol) -> UIViewController
    func navigateToCoffeeShops()
}

class RegistrationRouter: RegistrationRouterProtocol {
    weak var viewController: UIViewController?
    private var globalRouter: GlobalRouterProtocol?

    static func createModule(globalRouter: GlobalRouterProtocol) -> UIViewController {
        let view = RegistrationViewController()
        let presenter = RegistrationPresenter()
        let interactor = RegistrationInteractor()
        let router = RegistrationRouter()
        
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
