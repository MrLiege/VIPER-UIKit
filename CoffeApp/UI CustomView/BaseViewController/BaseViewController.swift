//
//  BaseViewController.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 09.11.2024.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    private let backButton = CoffeeValueButton(symbolName: "chevron.backward", symbolColor: UIColor.coffeeTitleColor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupNavigationBar()
    }
    
    private func configureViewController() {
        view.backgroundColor = .coffeeBackgroundNavigation
    }
    
    func setupNavigationBar(title: String = "", showBackButton: Bool = false) {
        let titleLabel = CoffeTitleLabel(textAlignment: .center, fontSize: 18, fontWeight: .bold)
        titleLabel.text = title
        navigationItem.titleView = titleLabel
        
        if showBackButton {
            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            let backBarButton = UIBarButtonItem(customView: backButton)
            navigationItem.leftBarButtonItem = backBarButton
        }
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = .coffeeLine
        navigationController?.navigationBar.addSubview(bottomLine)
        
        bottomLine.snp.makeConstraints { make in
            make.left.equalTo(navigationController!.navigationBar.snp.left)
            make.right.equalTo(navigationController!.navigationBar.snp.right)
            make.bottom.equalTo(navigationController!.navigationBar.snp.bottom)
            make.height.equalTo(2)
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
