//
//  RegistrationPresenter.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 06.11.2024.
//

import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
    func registrationButtonTapped(with login: String, password: String)
    func didRegistration(with response: ServerRegistrationResponse)
    func registrationFailed(with error: Error)
}

class RegistrationPresenter: RegistrationPresenterProtocol {
    weak var view: RegistrationViewProtocol?
    var interactor: RegistrationInteractorInputProtocol?
    var router: RegistrationRouterProtocol?
    private let userStorage = UserStorage.shared
    
    func registrationButtonTapped(with login: String, password: String) {
        let request = LocalRegistrationRequest(login: login, password: password)
        interactor?.registration(with: request)
    }
    
    func didRegistration(with response: ServerRegistrationResponse) {
        userStorage.token = response.token
        userStorage.isFirstLaunch = false
        view?.showRegistrationSuccess(response: response)
        router?.navigateToCoffeeShops()
    }
    
    func registrationFailed(with error: Error) {
        view?.showRegistrationError(error: error)
    }
}

