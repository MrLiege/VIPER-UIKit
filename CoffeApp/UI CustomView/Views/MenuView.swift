//
//  MenuView.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 30.10.2024.
//

import UIKit
import SnapKit

protocol MenuViewDelegate: AnyObject {
    func didChangeQuantity(for menuItem: MenuLocal, quantity: Int)
}

class MenuView: UIView {
    
    weak var delegate: MenuViewDelegate?
    var menuItem: MenuLocal?
    
    let containerView = UIView()
    let logoMenuImageView = UIImageView()
    let titleMenuLabel = CoffeTitleLabel(textAlignment: .left, fontSize: 15, fontWeight: .medium, 
                                         textColor: UIColor.coffeePlaceholderColor)
    let priceMenuLabel = CoffeTitleLabel(textAlignment: .left, fontSize: 14, fontWeight: .bold)
    let valueMenuLabel = CoffeTitleLabel(textAlignment: .left, fontSize: 14, fontWeight: .regular)
    let plusValueButton = CoffeeValueButton(symbolName: "plus", symbolColor: UIColor.coffeeTitleButton)
    let minusValueButton = CoffeeValueButton(symbolName: "minus", symbolColor: UIColor.coffeeTitleButton)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        plusValueButton.addTarget(self, action: #selector(incrementValue), for: .touchUpInside)
        minusValueButton.addTarget(self, action: #selector(decrementValue), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuView {
    private func setupUI() {
        valueMenuLabel.text = "0"
        
        addSubview(containerView)
        containerView.addSubview(logoMenuImageView)
        containerView.addSubview(titleMenuLabel)
        containerView.addSubview(priceMenuLabel)
        containerView.addSubview(valueMenuLabel)
        containerView.addSubview(plusValueButton)
        containerView.addSubview(minusValueButton)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true

        logoMenuImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(165)
            make.height.equalTo(137)
        }

        titleMenuLabel.snp.makeConstraints { make in
            make.top.equalTo(logoMenuImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(11)
        }

        priceMenuLabel.snp.makeConstraints { make in
            make.top.equalTo(titleMenuLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(11)
        }

        plusValueButton.snp.makeConstraints { make in
            make.top.equalTo(titleMenuLabel.snp.bottom).offset(9)
            make.right.equalToSuperview().inset(5)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }

        valueMenuLabel.snp.makeConstraints { make in
            make.top.equalTo(titleMenuLabel.snp.bottom).offset(12)
            make.right.equalTo(plusValueButton.snp.left).offset(-9)
        }

        minusValueButton.snp.makeConstraints { make in
            make.top.equalTo(titleMenuLabel.snp.bottom).offset(9)
            make.right.equalTo(valueMenuLabel.snp.left).offset(-9)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
    }
}

extension MenuView {
    @objc private func incrementValue() {
        if let currentValue = Int(valueMenuLabel.text ?? "0"), let menuItem = menuItem {
            let newValue = currentValue + 1
            
            self.valueMenuLabel.text = "\(newValue)"
            self.delegate?.didChangeQuantity(for: menuItem, quantity: newValue)
        }
    }

    @objc private func decrementValue() {
        if let currentValue = Int(valueMenuLabel.text ?? "0"), currentValue > 0, let menuItem = menuItem {
            let newValue = currentValue - 1
            self.valueMenuLabel.text = "\(newValue)"
            self.delegate?.didChangeQuantity(for: menuItem, quantity: newValue)
        }
    }
}
