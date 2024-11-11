//
//  CoffeeShopsService.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 29.10.2024.
//

import Moya
import Foundation
import CoreLocation

class CoffeeShopsService {
    let provider: MoyaProvider<LocationEndpoint> = {
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        return MoyaProvider<LocationEndpoint>(plugins: [logger])
    }()
    
    func fetchCoffeeShops(userCoordinates: CLLocationCoordinate2D, completion: @escaping (Result<[CoffeeShop], Error>) -> Void) {
        provider.request(.locations) { result in
            switch result {
            case .success(let response):
                do {
                    let locationResponses = try JSONDecoder().decode([LocationResponse].self, from: response.data)
                    print("Decoded locations: \(locationResponses)")
                    
                    let coffeeShops = locationResponses.map {
                        CoffeeShop(id: $0.id, name: $0.name, latitude: Double($0.point.latitude) ?? 0.0, longitude: Double($0.point.longitude) ?? 0.0)
                    }
                    print("Mapped coffeeShops: \(coffeeShops)")
                    
                    let userLocation = CLLocation(latitude: userCoordinates.latitude, longitude: userCoordinates.longitude)
                    let nearbyShops = coffeeShops.filter {
                        let shopLocation = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
                        let distance = shopLocation.distance(from: userLocation)
                        print("Distance to \($0.name): \(distance) meters")
                        return distance > 0
                    }
                    print("Nearby coffeeShops: \(nearbyShops)")
                    completion(.success(nearbyShops))
                } catch {
                    print("Decoding error: \(error)")
                    if response.statusCode == 401 {
                        completion(.failure(NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "token is not valid or has expired"])))
                    } else {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                if let response = error.response, response.statusCode == 401 {
                    completion(.failure(NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "token is not valid or has expired"])))
                } else {
                    print("Request error: \(error)")
                    completion(.failure(error))
                }
            }
        }
    }
}
