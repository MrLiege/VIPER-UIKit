//
//  CoffeeShopsCell.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 30.10.2024.
//

import UIKit
import SnapKit

class CoffeeShopsCell: UITableViewCell {
    static let reuseID = "CoffeeShopsCell"
    
    let containerView = UIView()
    let coffeeShopsView = CoffeeShopsView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CoffeeShopsCell {
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(coffeeShopsView)
        
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(65)
        }
        
        coffeeShopsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.backgroundColor = UIColor.coffeeBackgroundCells
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 2
    }
}

extension CoffeeShopsCell {
    func configure(with coffeShop: CoffeeShop, distance: Double) {
        coffeeShopsView.titleCafeLabel.text = coffeShop.name
        coffeeShopsView.distanceCafeLabel.text = String(format: "%.2f км от вас", distance / 1000)
    }
}
