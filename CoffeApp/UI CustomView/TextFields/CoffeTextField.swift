//
//  CoffeTextField.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 28.10.2024.
//

import UIKit

class CoffeTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        configure()
    }
}

extension CoffeTextField {
    private func configure() {
        layer.cornerRadius = frame.size.height / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.coffeeBorderColor.cgColor
        clipsToBounds = true
        isUserInteractionEnabled = true
        setLeftPaddingPoints(10)
        
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: UIColor.coffeePlaceholderColor,
                .font: UIFont.systemFont(ofSize: 18, weight: .regular)
            ]
        )
    }
    
    private func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height / 2
    }
}

extension CoffeTextField: UITextFieldDelegate {
    
}
