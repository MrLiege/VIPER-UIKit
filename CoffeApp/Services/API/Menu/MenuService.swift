//
//  MenuService.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 31.10.2024.
//

import Foundation
import Moya

class MenuService {
    let provider: MoyaProvider<MenuEndpoint> = {
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        return MoyaProvider<MenuEndpoint>(plugins: [logger])
    }()
    
    func fetchMenu(for locationId: Int, completion: @escaping (Result<[MenuServer], Error>) -> Void) {
        provider.request(.menu(locationId: locationId)) { result in
            switch result {
            case .success(let response):
                do {
                    let menuItems = try JSONDecoder().decode([MenuServer].self, from: response.data)
                    completion(.success(menuItems))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
