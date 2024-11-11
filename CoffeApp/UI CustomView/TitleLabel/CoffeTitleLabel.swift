//
//  CoffeTitleLabel.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 28.10.2024.
//

import UIKit

class CoffeTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(textAlignment: NSTextAlignment, fontSize: CGFloat, fontWeight: UIFont.Weight, textColor: UIColor = .coffeeTitleColor) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.textColor = textColor
        configure()
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
    }
}
