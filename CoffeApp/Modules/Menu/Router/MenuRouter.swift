//
//  MenuRouter.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 31.10.2024.
//

import Foundation
import UIKit

protocol MenuRouterProtocol: AnyObject {
    static func createModule(locationId: Int) -> UIViewController
    func navigateToOrders(with orders: [MenuLocal])
}

class MenuRouter: MenuRouterProtocol {
    weak var viewController: UIViewController?

    static func createModule(locationId: Int) -> UIViewController {
        let view = MenuViewController()
        let presenter = MenuPresenter()
        let service = MenuService()
        let interactor = MenuInteractor(service: service)
        let router = MenuRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        presenter.locationId = locationId
        router.viewController = view

        return view
    }

    func navigateToOrders(with orders: [MenuLocal]) {
        let ordersViewController = OrdersRouter.createModule(with: orders)
        viewController?.navigationController?.pushViewController(ordersViewController, animated: true)
    }
}
