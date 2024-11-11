//
//  OrdersCell.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 01.11.2024.
//

import UIKit
import SnapKit

class OrdersCell: UITableViewCell {
    static let reuseID = "OrdersCell"

    let containerView = UIView()
    let ordersView = OrdersView()
    var presenter: OrdersPresenterProtocol?
    var order: MenuLocal?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(ordersView)

        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(71)
        }

        ordersView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        containerView.backgroundColor = UIColor.coffeeBackgroundCells
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 2
    }
    
    func configure(with order: MenuLocal) {
        ordersView.titleOrderLabel.text = order.name
        ordersView.priceLabel.text = "\(order.formattedPrice) руб"
        ordersView.valueMenuLabel.text = String(order.quantity)
        ordersView.order = order
        ordersView.delegate = self
    }
}

extension OrdersCell: OrdersViewDelegate {
    func didChangeOrderQuantity(for order: MenuLocal, quantity: Int) {
        presenter?.updateOrderQuantity(order: order, quantity: quantity)
    }
}
