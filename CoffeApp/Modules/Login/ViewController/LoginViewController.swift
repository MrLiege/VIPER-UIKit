//
//  ViewController.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 28.10.2024.
//

import UIKit
import SnapKit

// MARK: - View Protocol
protocol LoginViewProtocol: AnyObject {
    func showLoginSuccess(response: ServerLoginResponse)
    func showLoginError(error: Error)
}

// MARK: - LoginViewController Implementation
class LoginViewController: BaseViewController {
    var presenter: LoginPresenterProtocol?
    
    private let userStorage = UserStorage.shared

    private let emailField = LabelTextField(titleText: "e-mail", placeholder: "example@example.ru")
    private let passwordField: LabelTextField = {
        let field = LabelTextField(titleText: "Пароль", placeholder: "******")
        field.textField.isSecureTextEntry = true
        return field
    }()
    private let loginButton = CoffeButton(titleColor: UIColor.coffeeTitleButton, 
                                          backgroundColor: UIColor.coffeeBackgroundButton,
                                          title: "Войти")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupUI()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        if let token = UserStorage.shared.token {
            print("Сохраненный токен: \(token)")
        } else {
            print("No token found.")
        }
    }
}

 // MARK: - Constraint UI Elements + Config NavigatioinBar
extension LoginViewController {
    func setupUI() {
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        
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
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordField.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
            make.height.equalTo(48)
        }
    }
    
    private func configureViewController() {
        setupNavigationBar(title: "Вход", showBackButton: false)
    }
}

extension LoginViewController {
    @objc private func loginButtonTapped() {
        guard let email = emailField.textField.text, let password = passwordField.textField.text else { return }
        presenter?.loginButtonTapped(with: email, password: password)
    }
}

// MARK: - LoginViewProtocol Methods
extension LoginViewController: LoginViewProtocol {
    func showLoginSuccess(response: ServerLoginResponse) {
        print("Logged in with token: \(response.token), token lifetime: \(response.tokenLifetime)")
    }
    
    func showLoginError(error: Error) {
        print("Login failed: \(error.localizedDescription)")
    }
}
