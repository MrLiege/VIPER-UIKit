//
//  MenuViewController.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 31.10.2024.
//

import UIKit
import SnapKit

class MenuViewController: BaseViewController {
    var presenter: MenuPresenterProtocol?
    private var menuItems: [MenuLocal] = []
    private let proceedPaymentButton = CoffeButton(titleColor: UIColor.coffeeTitleButton,
                                             backgroundColor: UIColor.coffeeBackgroundButton,
                                             title: "Перейти к оплате")
    
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionView()
        setupUI()
        configureViewController()
        presenter?.viewDidLoad()
        proceedPaymentButton.addTarget(self, action: #selector(proceedPaymentButtonTapped), for: .touchUpInside)
    }
    
    @objc func proceedPaymentButtonTapped() {
        for cell in collectionView.visibleCells {
            if let menuCell = cell as? MenuCell,
                var menuItem = menuCell.menuItem,
                let valueText = menuCell.menuView.valueMenuLabel.text,
                let quantity = Int(valueText) {
                menuItem.quantity = quantity
            }
        }
        presenter?.didTapProceedPaymentButton()
    }
    
    private func configureViewController() {
        setupNavigationBar(title: "Меню", showBackButton: true)
    }
}

private extension MenuViewController {
    func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(proceedPaymentButton)
        
        proceedPaymentButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(19)
            make.right.equalToSuperview().inset(19)
            make.bottom.equalToSuperview().inset(32)
            make.height.equalTo(47)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(proceedPaymentButton.snp.top).offset(-21)
        }
    }
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    private func configureCollectionView() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 13
            layout.minimumInteritemSpacing = 13
            let cellWidth = (UIScreen.main.bounds.width - 45) / 2
            layout.itemSize = CGSize(width: cellWidth, height: 221)
            
            layout.headerReferenceSize = CGSize(width: view.frame.width, height: 16)
        }
        
        collectionView.backgroundColor = .white
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.menuItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.reuseID, for: indexPath) as! MenuCell
        if let menuItem = presenter?.menuItems[indexPath.row] {
            cell.configure(with: menuItem)
            cell.presenter = presenter
            cell.tag = indexPath.row
            print("Configured cell at index \(indexPath.row) with menu item: \(menuItem)")
        }
        return cell
    }
}

protocol MenuViewProtocol: AnyObject {
    func showMenu(_ menuItems: [MenuLocal])
    func showError(_ error: String)
}

extension MenuViewController: MenuViewProtocol, MenuPresenterDelegate {
    func showMenu(_ menuItems: [MenuLocal]) {
        self.menuItems = menuItems
        collectionView.reloadData()
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func didUpdateMenuItems(_ menuItems: [MenuLocal]) {
        self.menuItems = menuItems
    }
}
