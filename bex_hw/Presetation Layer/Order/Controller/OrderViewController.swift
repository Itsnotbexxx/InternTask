//
//  OrderViewController.swift
//  bex_hw
//
//  Created by Abylbek Khassenov on 28.05.2022.
//

import UIKit

class OrderViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.cellIdentifier())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    private lazy var payButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Оплатить", for: .normal)
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.backgroundColor = .systemGreen
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(touchBtn), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        // Do any additional setup after loading the view.
        title = "Basket"
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.transition(with: self.view, duration: 0.25, options: .transitionCrossDissolve, animations: { [self] in
            if OrdersList.shared.basketList.count > 0 {
                payButton.isHidden = false
            } else {
                payButton.isHidden = true
            }
            tableView.reloadData()
        }, completion: nil)
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(payButton)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        payButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-120)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
    
    @objc private func touchBtn(){
        let paymentVC = PaymentViewController()
        navigationController?.pushViewController(paymentVC, animated: true)
    }
}

//  MARK: - TABLEVIEW DELEGATE
extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrdersList.shared.basketList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.cellIdentifier(), for: indexPath) as! OrderTableViewCell
        cell.configure(model: OrdersList.shared.basketList[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - TALBE VIEW CELL EXTENSION
extension UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

// MARK: - ORDER TABLE VIEW CELL DELEGATE
extension OrderViewController: OrderTableViewCellDelegate {
    func reloadTable() {
        UIView.transition(with: self.view, duration: 0.25, options: .transitionCrossDissolve, animations: { [self] in
            if OrdersList.shared.basketList.count > 0 {
                payButton.isHidden = false
            } else {
                payButton.isHidden = true
            }
            tableView.reloadData()
        }, completion: nil)
    }
}
