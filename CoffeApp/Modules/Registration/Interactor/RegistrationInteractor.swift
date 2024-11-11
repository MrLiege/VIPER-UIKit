//
//  RegistrationInteractor.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 06.11.2024.
//

import Foundation

// MARK: - Interactor Protocols
protocol RegistrationInteractorInputProtocol: AnyObject {
    func registration(with request: LocalRegistrationRequest)
}

protocol RegistrationInteractorOutputProtocol: AnyObject {
    func didRegistration(with response: ServerRegistrationResponse)
    func registrationFailed(with error: Error)
}

// MARK: - LoginInteractor Implementation
class RegistrationInteractor: RegistrationInteractorInputProtocol {
    var presenter: RegistrationPresenterProtocol?
    var service: RegistrationServiceProtocol? = RegistrationService()
    
    func registration(with request: LocalRegistrationRequest) {
        service?.register(with: request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter?.didRegistration(with: response)
            case .failure(let error):
                self?.presenter?.registrationFailed(with: error)
            }
        }
    }
}
