//
//  LoginInteractor.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 28.10.2024.
//

import Foundation

// MARK: - Interactor Protocols
protocol LoginInteractorInputProtocol: AnyObject {
    func login(with request: LocalLoginRequest)
}

protocol LoginInteractorOutputProtocol: AnyObject {
    func didLogin(with response: ServerLoginResponse)
    func loginFailed(with error: Error)
}

// MARK: - LoginInteractor Implementation
class LoginInteractor: LoginInteractorInputProtocol {
    var presenter: LoginPresenterProtocol?
    var service: LoginServiceProtocol? = LoginService()
    
    func login(with request: LocalLoginRequest) {
        print("Interactor login called with request: \(request)")
        service?.login(with: request) { [weak self] result in
            switch result {
            case .success(let response):
                print("Login successful with response: \(response)")
                self?.presenter?.didLogin(with: response)
            case .failure(let error):
                print("Login failed with error: \(error)")
                self?.presenter?.loginFailed(with: error)
            }
        }
    }
}
