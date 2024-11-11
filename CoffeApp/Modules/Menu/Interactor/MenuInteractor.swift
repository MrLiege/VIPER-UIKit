//
//  MenuInteractor.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 31.10.2024.
//

import Foundation

protocol MenuInteractorInputProtocol: AnyObject {
    func fetchMenu(locationId: Int)
}

protocol MenuInteractorOutputProtocol: AnyObject {
    func didFetchMenu(_ menuItems: [MenuServer])
    func didFailToFetchMenu(with error: Error)
}

class MenuInteractor: MenuInteractorInputProtocol {
    weak var presenter: MenuInteractorOutputProtocol?
    let service: MenuService
    
    init(service: MenuService) {
        self.service = service
    }
    
    func fetchMenu(locationId: Int) {
        print("Fetching menu for locationId: \(locationId)")
        service.fetchMenu(for: locationId) { [weak self] result in
            switch result {
            case .success(let menuItems):
                print("Fetched menu items: \(menuItems)")
                self?.presenter?.didFetchMenu(menuItems)
            case .failure(let error):
                print("Failed to fetch menu items with error: \(error)")
                self?.presenter?.didFailToFetchMenu(with: error)
            }
        }
    }
}
