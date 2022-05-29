//
//  OrderTableViewCell.swift
//  bex_hw
//
//  Created by Nurpeiis Bexultan on 29.05.2022.
//

import UIKit

protocol OrderTableViewCellDelegate {
    func reloadTable()
}

class OrderTableViewCell: UITableViewCell {
    
    // MARK: - VARIABLES
    private var oldValue: Double = 0
    private var model: Basket?
    var delegate: OrderTableViewCellDelegate?

    // MARK: - PROPERTIES
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .darkGray
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        return label
    }()
    private let stepper: UIStepper = {
        let stepper = UIStepper()
//        stepper.wraps = true
        stepper.autorepeat = true
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        return stepper
    }()
    private lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.tintColor = .lightGray
        btn.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
        return btn
    }()
    
    //  MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SETUP FUNCTIONS
    private func setupViews() {
        contentView.isUserInteractionEnabled = true
        
        addSubview(leftImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        addSubview(priceLabel)
        addSubview(stepper)
        addSubview(closeButton)
        
        leftImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(80)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(leftImageView.snp.right).offset(8)
            make.right.equalTo(closeButton.snp.left).offset(-8)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.width.equalTo(10)
        }
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(titleLabel.snp.left)
        }
        stepper.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(16)
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalToSuperview().offset(-12)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(stepper.snp.top)
            make.right.equalToSuperview().offset(-12)
        }
    }
    
    // MARK: - ACTIONS
    @objc private func stepperValueChanged(_ stepper: UIStepper){
        if (stepper.value > oldValue) {
            oldValue = oldValue + 1
            //Your Code You Wanted To Perform On Increment

            let totalPrice = (model?.menu?.price ?? 0) * Int(stepper.value)
            priceLabel.text = String(totalPrice) + " тг"
            if let index = OrdersList.shared.basketList.firstIndex(where: { $0.menu?.id == model?.menu?.id }) {
                OrdersList.shared.basketList[index].count += 1
            }
        }
        else {
             oldValue = oldValue - 1
             //Your Code You Wanted To Perform On Decrement
            let totalPrice = (model?.menu?.price ?? 0) * Int(stepper.value)
            priceLabel.text = String(totalPrice) + " тг"
            if OrdersList.shared.basketList.contains(where: { $0.menu?.id == model?.menu?.id
            }) {
                if let index = OrdersList.shared.basketList.firstIndex(where: { $0.menu?.id == model?.menu?.id }) {
                    if OrdersList.shared.basketList[index].count > 1 {
                        OrdersList.shared.basketList[index].count -= 1
                    } else {
                        UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: { [self] in
                            OrdersList.shared.basketList.removeAll(where: { $0.menu?.id == model?.menu?.id })
                            delegate?.reloadTable()
                        }, completion: nil)
                    }
                }
            }
        }
        countLabel.text = String(Int(stepper.value)) + " kg"
    }
    @objc private func tapClose() -> Void {
        UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: { [self] in
            OrdersList.shared.basketList.removeAll(where: { $0.menu?.id == model?.menu?.id })
            delegate?.reloadTable()
        }, completion: nil)
    }

    
    // MARK: - CONFIGURE
    func configure(model: Basket?) {
        if let model = model {
            self.model = model
            oldValue = Double(model.count)
            stepper.value = Double(model.count)
            leftImageView.image = model.menu?.image
            titleLabel.text = model.menu?.title
            countLabel.text = "\(model.count) kg"
            priceLabel.text = "\(model.count * (model.menu?.price ?? 0)) тг"
        }
    }
}

