//
//  RegistrationService.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 06.11.2024.
//

import Moya
import Foundation

protocol RegistrationServiceProtocol {
    func register(with request: LocalRegistrationRequest, completion: @escaping (Result<ServerRegistrationResponse, Error>) -> Void)
}

class RegistrationService: RegistrationServiceProtocol {
    private let provider = MoyaProvider<AuthEndpoint>()
    private let userStorage = UserStorage.shared
    func register(with request: LocalRegistrationRequest, completion: @escaping (Result<ServerRegistrationResponse, Error>) -> Void) {
        provider.request(.registration(login: request.login, password: request.password)) {
            result in switch result { 
            case .success(let response):
                do {
                    let registrationResponse = try JSONDecoder().decode(ServerRegistrationResponse.self, from: response.data)
                    self.userStorage.token = registrationResponse.token
                    completion(.success(registrationResponse))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error): 
                completion(.failure(error))
            }
        }
    }
}
