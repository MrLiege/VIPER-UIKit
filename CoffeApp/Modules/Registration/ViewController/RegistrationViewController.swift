//
//  RegistrationViewController.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 06.11.2024.
//

import UIKit
import SnapKit

protocol RegistrationViewProtocol: AnyObject {
    func showRegistrationSuccess(response: ServerRegistrationResponse)
    func showRegistrationError(error: Error)
}

class RegistrationViewController: UIViewController {
    var presenter: RegistrationPresenterProtocol?
    private let userStorage = UserStorage.shared

    private let emailField = LabelTextField(titleText: "e-mail", placeholder: "example@example.ru")
    private let passwordField = LabelTextField(titleText: "Пароль", placeholder: "******")
    private let passwordRepeatField = LabelTextField(titleText: "Повторите пароль", placeholder: "******")
        
    private let registrationButton = CoffeButton(titleColor: UIColor.coffeeTitleButton,
                                          backgroundColor: UIColor.coffeeBackgroundButton,
                                          title: "Регистрация")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        updateRegistrationButtonState()
    }
}

extension RegistrationViewController {
    func setupUI() {
        configureTextFields()
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(passwordRepeatField)
        view.addSubview(registrationButton)
        
        emailField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-150)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
        }
        
        passwordField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailField.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
        }
        
        passwordRepeatField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordField.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordRepeatField.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
            make.height.equalTo(48)
        }
    }
    
    func configureTextFields() {
        passwordField.textField.isSecureTextEntry = true
        passwordRepeatField.textField.isSecureTextEntry = true
        passwordField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordRepeatField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
}

extension RegistrationViewController {
    @objc private func registrationButtonTapped() {
        guard let email = emailField.textField.text, let password = passwordField.textField.text else { return }
        presenter?.registrationButtonTapped(with: email, password: password)
    }
    
    @objc private func textFieldDidChange() {
        updateRegistrationButtonState()
    }
    
    @objc private func updateRegistrationButtonState() {
        let passwordsMatch = passwordField.textField.text == passwordRepeatField.textField.text
        registrationButton.isEnabled = passwordsMatch
    }
}

extension RegistrationViewController: RegistrationViewProtocol {
    func showRegistrationSuccess(response: ServerRegistrationResponse) {
        print("Logged in with token: \(response.token), token lifetime: \(response.tokenLifetime)")
    }
    
    func showRegistrationError(error: any Error) {
        print("Login failed: \(error.localizedDescription)")
    }
}
