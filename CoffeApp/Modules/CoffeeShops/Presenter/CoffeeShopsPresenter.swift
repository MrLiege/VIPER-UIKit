//
//  CoffeeShopsPresenter.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 29.10.2024.
//

import CoreLocation

protocol CoffeeShopsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didFetchCoffeeShops(_ coffeeShops: [CoffeeShop])
    func didFailToFetchCoffeeShops(with error: Error)
    func didSelectCoffeeShop(at index: Int)
}

class CoffeeShopsPresenter: CoffeeShopsPresenterProtocol {
    weak var view: CoffeeShopsViewProtocol?
    var interactor: CoffeeShopsInteractorInputProtocol?
    var router: CoffeeShopsRouterProtocol?
    private var coffeeShops: [CoffeeShop] = []
    private let locationManager = LocationManager()
    private var userCoordinates: CLLocationCoordinate2D?
    
    func viewDidLoad() {
        print("viewDidLoad called")
        locationManager.didUpdateLocation = { [weak self] coordinates in
            print("User location: \(coordinates.latitude), \(coordinates.longitude)")
            self?.userCoordinates = coordinates
            self?.interactor?.fetchCoffeeShops(userCoordinates: coordinates)
        }
        locationManager.requestLocationPermission()
    }

    func didFetchCoffeeShops(_ coffeeShops: [CoffeeShop]) {
        print("didFetchCoffeeShops called with coffeeShops: \(coffeeShops)")
        self.coffeeShops = coffeeShops

        guard let userCoordinates = userCoordinates else {
            view?.showCoffeeShopsWithDistances(coffeeShops.map { CoffeeShopWithDistance(coffeeShop: $0, distance: 0) })
            return
        }

        let userLocation = CLLocation(latitude: userCoordinates.latitude, longitude: userCoordinates.longitude)
        let coffeeShopsWithDistances = coffeeShops.map { coffeeShop -> CoffeeShopWithDistance in
            let shopLocation = CLLocation(latitude: coffeeShop.latitude, longitude: coffeeShop.longitude)
            let distance = shopLocation.distance(from: userLocation)
            return CoffeeShopWithDistance(coffeeShop: coffeeShop, distance: distance)
        }

        view?.showCoffeeShopsWithDistances(coffeeShopsWithDistances)
    }
    
    func didFailToFetchCoffeeShops(with error: Error) {
        print("didFailToFetchCoffeeShops called with error: \(error)")
        if (error as NSError).code == 401 {
            router?.navigateToLogin()
        } else {
            view?.showError(error.localizedDescription)
        }
    }
    
    func didSelectCoffeeShop(at index: Int) {
        let selectedCoffeeShop = coffeeShops[index]
        router?.navigateToMenu(locationId: selectedCoffeeShop.id)
    }
}

extension CoffeeShopsPresenter: CoffeeShopsInteractorOutputProtocol {}
