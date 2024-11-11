//
//  LoginService.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 28.10.2024.
//

import Moya
import Foundation

protocol LoginServiceProtocol {
    func login(with request: LocalLoginRequest, completion: @escaping (Result<ServerLoginResponse, Error>) -> Void)
}

class LoginService: LoginServiceProtocol {
    private let provider = MoyaProvider<AuthEndpoint>()
    private let userStorage = UserStorage.shared
    
    func login(with request: LocalLoginRequest, completion: @escaping (Result<ServerLoginResponse, Error>) -> Void) {
        provider.request(.login(login: request.login, password: request.password)) { result in
            switch result {
            case .success(let response):
                do {
                    let loginResponse = try JSONDecoder().decode(ServerLoginResponse.self, from: response.data)
                    self.userStorage.token = loginResponse.token

                    completion(.success(loginResponse))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
