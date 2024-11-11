//
//  LabelTextField.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 28.10.2024.
//

import UIKit
import SnapKit

class LabelTextField: UIView {
    let title: CoffeTitleLabel
    let textField: CoffeTextField

    init(titleText: String, placeholder: String) {
        self.title = CoffeTitleLabel(textAlignment: .left, fontSize: 15, fontWeight: .regular)
        self.textField = CoffeTextField(placeholder: placeholder)
        super.init(frame: .zero)
        self.title.text = titleText
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LabelTextField {
    private func setupUI() {
        addSubview(title)
        addSubview(textField)

        title.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }

        textField.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
    }

    override var intrinsicContentSize: CGSize {
        let titleHeight = title.intrinsicContentSize.height
        let textFieldHeight = textField.intrinsicContentSize.height
        return CGSize(width: UIView.noIntrinsicMetric, height: titleHeight + textFieldHeight + 8)
    }
}
