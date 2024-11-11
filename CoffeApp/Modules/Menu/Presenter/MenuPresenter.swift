//
//  MenuPresenter.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 31.10.2024.
//

import Foundation

protocol MenuPresenterProtocol: AnyObject {
    var menuItems: [MenuLocal] { get }
    func viewDidLoad()
    func didTapProceedPaymentButton()
    func didFetchMenu(_ menuItems: [MenuServer])
    func didFailToFetchMenu(with error: Error)
    func updateMenuItemQuantity(menuItem: MenuLocal, quantity: Int)
}

protocol MenuPresenterDelegate: AnyObject {
    func didUpdateMenuItems(_ menuItems: [MenuLocal])
}

class MenuPresenter: MenuPresenterProtocol {
    weak var view: MenuViewProtocol?
    var interactor: MenuInteractorInputProtocol?
    var router: MenuRouterProtocol?
    var locationId: Int?
    var menuItems: [MenuLocal] = []
    var orders: [MenuLocal] = []
    weak var delegate: MenuPresenterDelegate?

    func viewDidLoad() {
        guard let locationId = locationId else { return }
        interactor?.fetchMenu(locationId: locationId)
    }

    func updateMenuItemQuantity(menuItem: MenuLocal, quantity: Int) {
        if let index = menuItems.firstIndex(where: { $0.id == menuItem.id }) {
            menuItems[index].quantity = quantity
            print("Updated MenuItem with id \(menuItem.id) to quantity \(quantity)")
        }
    }

    func didTapProceedPaymentButton() {
        let orders = menuItems.filter { $0.quantity > 0 }
        print("Filtered orders: \(orders)")
        router?.navigateToOrders(with: orders)
    }

    func didFetchMenu(_ menuItems: [MenuServer]) {
        let localMenuItems = menuItems.map { MenuLocal(from: $0) }
        self.menuItems = localMenuItems
        view?.showMenu(localMenuItems)
    }

    func didFailToFetchMenu(with error: Error) {
        view?.showError(error.localizedDescription)
    }
}

extension MenuPresenter: MenuInteractorOutputProtocol {}
