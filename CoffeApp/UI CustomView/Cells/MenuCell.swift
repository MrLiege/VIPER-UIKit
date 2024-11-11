//
//  MenuCell.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 31.10.2024.
//

import UIKit
import SnapKit

class MenuCell: UICollectionViewCell {
    static let reuseID = "MenuViewCell"
    let menuView = MenuView()
    private let containerView = UIView()
    var presenter: MenuPresenterProtocol?
    var menuItem: MenuLocal?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(menuView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
            make.height.equalTo(205)
        }
        
        menuView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 2
    }
    
    func configure(with menuItem: MenuLocal) {
        self.menuItem = menuItem
        menuView.menuItem = menuItem
        menuView.titleMenuLabel.text = menuItem.name
        menuView.priceMenuLabel.text = "\(menuItem.formattedPrice) руб"
        if let url = URL(string: menuItem.imageURL) {
            loadImage(from: url) { [weak self] image in self?.menuView.logoMenuImageView.image = image
            }
        }
        menuView.valueMenuLabel.text = "\(menuItem.quantity)" 
        menuView.delegate = self
    }
    
    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}

extension MenuCell: MenuViewDelegate {
    func didChangeQuantity(for menuItem: MenuLocal, quantity: Int) {
        presenter?.updateMenuItemQuantity(menuItem: menuItem, quantity: quantity)
    }
}
