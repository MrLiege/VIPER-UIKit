//
//  CellCoffeeShopsView.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 30.10.2024.
//

import UIKit
import SnapKit

class CoffeeShopsView: UIView {
    let titleCafeLabel = CoffeTitleLabel(textAlignment: .left, fontSize: 18, fontWeight: .bold)
    let distanceCafeLabel = CoffeTitleLabel(textAlignment: .left, fontSize: 14, 
                                            fontWeight: .regular,
                                            textColor: UIColor.coffeePlaceholderColor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CoffeeShopsView {
    private func setupUI() {        
        addSubview(titleCafeLabel)
        addSubview(distanceCafeLabel)
        
        titleCafeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.left.equalToSuperview().offset(10)
        }
        
        distanceCafeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleCafeLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(10)
        }
    }
}
