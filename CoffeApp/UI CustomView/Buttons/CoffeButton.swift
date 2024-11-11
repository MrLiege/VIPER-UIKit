//
//  CoffeButton.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 29.10.2024.
//

import UIKit

class CoffeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(titleColor: UIColor, backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        set(titleColor: titleColor, backgroundColor: backgroundColor, title: title)
    }
    
    private func configure() {
        configuration = .filled()
        configuration?.cornerStyle = .capsule
        addShadow()
    }
    
    final func set(titleColor: UIColor, backgroundColor: UIColor, title: String) {
        configuration?.baseForegroundColor = titleColor
        configuration?.baseBackgroundColor = backgroundColor
        configuration?.title = title
        
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 18)
        configuration?.attributedTitle = AttributedString(title, attributes: container)
    }
    
    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }
}
