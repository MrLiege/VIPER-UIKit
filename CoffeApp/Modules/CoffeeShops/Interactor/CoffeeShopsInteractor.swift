//
//  CoffeeShopsInteractor.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 29.10.2024.
//

import CoreLocation

protocol CoffeeShopsInteractorInputProtocol: AnyObject {
    func fetchCoffeeShops(userCoordinates: CLLocationCoordinate2D)
}

protocol CoffeeShopsInteractorOutputProtocol: AnyObject {
    func didFetchCoffeeShops(_ coffeeShops: [CoffeeShop])
    func didFailToFetchCoffeeShops(with error: Error)
}

class CoffeeShopsInteractor: CoffeeShopsInteractorInputProtocol {
    weak var presenter: CoffeeShopsInteractorOutputProtocol?
    let service: CoffeeShopsService
    
    init(service: CoffeeShopsService) {
        self.service = service
    }
    
    func fetchCoffeeShops(userCoordinates: CLLocationCoordinate2D) {
        print("fetchCoffeeShops called with userCoordinates: \(userCoordinates)")
        service.fetchCoffeeShops(userCoordinates: userCoordinates) { [weak self] result in
            switch result {
            case .success(let coffeeShops):
                print("Service fetched coffeeShops: \(coffeeShops)")
                self?.presenter?.didFetchCoffeeShops(coffeeShops)
            case .failure(let error):
                print("Service failed to fetch coffeeShops with error: \(error)")
                self?.presenter?.didFailToFetchCoffeeShops(with: error)
            }
        }
    }
}
