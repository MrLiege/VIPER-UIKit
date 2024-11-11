//
//  LoginPresenter.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 28.10.2024.
//

import Foundation

// MARK: - Presenter Protocols
protocol LoginPresenterProtocol: AnyObject {
    func loginButtonTapped(with login: String, password: String)
    func didLogin(with response: ServerLoginResponse)
    func loginFailed(with error: Error)
}

// MARK: - LoginPresenter Implementation
class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var router: LoginRouterProtocol?
    private let userStorage = UserStorage.shared
    
    func loginButtonTapped(with login: String, password: String) {
        let request = LocalLoginRequest(login: login, password: password)
        interactor?.login(with: request)
    }

    func didLogin(with response: ServerLoginResponse) {
        view?.showLoginSuccess(response: response)
        router?.navigateToCoffeeShops()
    }

    func loginFailed(with error: Error) {
        print("loginFailed called with error: \(error)")
        view?.showLoginError(error: error)
    }
}
