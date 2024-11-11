//
//  CoffeeValueButton.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 30.10.2024.
//

import UIKit

class CoffeeValueButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(symbolName: String, symbolColor: UIColor) {
        self.init(frame: .zero)
        set(symbolName: symbolName, symbolColor: symbolColor)
    }
    
    private func configure() {
        configuration = .plain()
        configuration?.cornerStyle = .capsule
        configuration?.baseBackgroundColor = .clear
    }
    
    final func set(symbolName: String, symbolColor: UIColor) {
        if var config = configuration {
            config.image = UIImage(systemName: symbolName, withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
            config.baseForegroundColor = symbolColor
            configuration = config
        }
    }
}
