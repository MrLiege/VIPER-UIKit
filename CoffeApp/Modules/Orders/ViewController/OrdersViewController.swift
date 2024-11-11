//
//  OrdersViewController.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 01.11.2024.
//

import UIKit
import SnapKit

protocol OrdersViewProtocol: AnyObject {
    func showOrders(_ orders: [MenuLocal])
}

class OrdersViewController: BaseViewController {
    var presenter: OrdersPresenterProtocol?
    var tableView: UITableView!
    var footerContainerView: UIView = UIView()
    var orders: [MenuLocal] = []
    private let payButton = CoffeButton(titleColor: UIColor.coffeeTitleButton,
                                        backgroundColor: UIColor.coffeeBackgroundButton,
                                        title: "Оплатить")
    private let orderWaitingTimeLabel = CoffeTitleLabel(textAlignment: .center, fontSize: 24, fontWeight: .medium)
    private var isPayButtonPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableView()
        setupUI()
        configureViewController()
        presenter?.viewDidLoad()
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
    }
}

extension OrdersViewController {
    @objc func payButtonTapped() {
        isPayButtonPressed = true
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        tableView.reloadData()
    }
}

extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrdersCell.reuseID, for: indexPath) as! OrdersCell
        let order = orders[indexPath.row]
        cell.configure(with: order)
        cell.tag = indexPath.row
        cell.presenter = presenter
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if !orders.isEmpty && isPayButtonPressed {
            orderWaitingTimeLabel.text = "Время ожидания заказа\n15 минут.\nСпасибо, что выбрали нас!"
        } else if orders.isEmpty {
            orderWaitingTimeLabel.text = "Упс, кажется ваш заказ пустой:("
        }
        
        return footerContainerView
    }
}

extension OrdersViewController {
    private func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrdersCell.self, forCellReuseIdentifier: OrdersCell.reuseID)
        tableView.separatorStyle = .none
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 16))
        tableView.tableHeaderView = headerView
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(payButton)
        view.addSubview(footerContainerView)
        footerContainerView.addSubview(orderWaitingTimeLabel)
        
        orderWaitingTimeLabel.numberOfLines = 0
        
        payButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(19)
            make.right.equalToSuperview().inset(19)
            make.bottom.equalToSuperview().inset(32)
            make.height.equalTo(47)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(payButton.snp.top).offset(-21)
        }
        
        orderWaitingTimeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(13)
            make.right.equalToSuperview().inset(13)
            make.top.equalToSuperview().inset(80)
            make.center.equalToSuperview()
        }
    }
    
    private func configureViewController() {
        setupNavigationBar(title: "Ваш заказ", showBackButton: true)
    }
}

extension OrdersViewController: OrdersViewProtocol {
    func showOrders(_ orders: [MenuLocal]) {
        self.orders = orders
        tableView.reloadData()
    }
}
