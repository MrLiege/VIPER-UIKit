//
//  OrdersView.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 01.11.2024.
//

import UIKit
import SnapKit

protocol OrdersViewDelegate: AnyObject {
    func didChangeOrderQuantity(for order: MenuLocal, quantity: Int)
}

class OrdersView: UIView {
    weak var delegate: OrdersViewDelegate?
    var order: MenuLocal?
    
    let titleOrderLabel = CoffeTitleLabel(textAlignment: .left, fontSize: 18, fontWeight: .bold)
    let priceLabel = CoffeTitleLabel(textAlignment: .left, fontSize: 16, fontWeight: .medium,
                                            textColor: UIColor.coffeePlaceholderColor)
    let valueMenuLabel = CoffeTitleLabel(textAlignment: .left, fontSize: 14, fontWeight: .bold)
    let plusValueButton = CoffeeValueButton(symbolName: "plus", symbolColor: UIColor.coffeeTitleColor)
    let minusValueButton = CoffeeValueButton(symbolName: "minus", symbolColor: UIColor.coffeeTitleColor)
    
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

private extension OrdersView {
    func setupUI() {
        addSubview(titleOrderLabel)
        addSubview(priceLabel)
        addSubview(plusValueButton)
        addSubview(valueMenuLabel)
        addSubview(minusValueButton)
        
        titleOrderLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(14)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(titleOrderLabel.snp.bottom).offset(6)
        }
        
        plusValueButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        valueMenuLabel.snp.makeConstraints { make in
            make.right.equalTo(plusValueButton.snp.left).offset(-9)
            make.centerY.equalToSuperview()
        }
        
        minusValueButton.snp.makeConstraints { make in
            make.right.equalTo(valueMenuLabel.snp.left).offset(-9)
            make.centerY.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
    }
}

extension OrdersView {
    @objc private func incrementValue() {
        if let currentValue = Int(valueMenuLabel.text ?? "0"), let order = order {
            let newValue = currentValue + 1 
            self.valueMenuLabel.text = "\(newValue)"
            self.delegate?.didChangeOrderQuantity(for: order, quantity: newValue)
        }
    }
    
    @objc private func decrementValue() {
        if let currentValue = Int(valueMenuLabel.text ?? "0"), currentValue > 0, let order = order {
            let newValue = currentValue - 1
            self.valueMenuLabel.text = "\(newValue)"
            self.delegate?.didChangeOrderQuantity(for: order, quantity: newValue)
        }
    }
}
