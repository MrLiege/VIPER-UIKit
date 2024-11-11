//
//  CoffeeShopsViewController.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 29.10.2024.
//

import UIKit
import SnapKit

class CoffeeShopsViewController: BaseViewController {
    var presenter: CoffeeShopsPresenterProtocol?
    private var coffeeShops: [CoffeeShopWithDistance] = []
    private let mapButton = CoffeButton(titleColor: UIColor.coffeeTitleButton,
                                        backgroundColor: UIColor.coffeeBackgroundButton,
                                        title: "На карте")
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableView()
        configureViewController()
        setupUI()
        presenter?.viewDidLoad()
    }
}

//MARK: -- Config NavigationBar and TableView
extension CoffeeShopsViewController {
    private func configureViewController() {
        setupNavigationBar(title: "Ближайшие кофейни", showBackButton: false)
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CoffeeShopsCell.self, forCellReuseIdentifier: CoffeeShopsCell.reuseID)
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 16))
        tableView.tableHeaderView = headerView
    }
}

extension CoffeeShopsViewController {
    func setupUI() {
        view.addSubview(tableView)
        view.addSubview(mapButton)
        
        mapButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(19)
            make.right.equalToSuperview().inset(19)
            make.bottom.equalToSuperview().inset(32)
            make.height.equalTo(47)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(mapButton.snp.top).offset(-21)
        }
    }
}

// MARK: -- UITableView
extension CoffeeShopsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeShops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoffeeShopsCell.reuseID, for: indexPath) as! CoffeeShopsCell
        let coffeeShopWithDistance = coffeeShops[indexPath.row]
                
        cell.configure(with: coffeeShopWithDistance.coffeeShop, distance: coffeeShopWithDistance.distance)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectCoffeeShop(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6
    }
}

// MARK: - Protocols implementation
protocol CoffeeShopsViewProtocol: AnyObject {
    func showCoffeeShopsWithDistances(_ coffeeShops: [CoffeeShopWithDistance])
    func showError(_ error: String)
}

extension CoffeeShopsViewController: CoffeeShopsViewProtocol {
    func showCoffeeShopsWithDistances(_ coffeeShops: [CoffeeShopWithDistance]) {
        print("Fetched coffee shops: \(coffeeShops)")
        self.coffeeShops = coffeeShops
        tableView.reloadData()
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
