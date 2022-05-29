//
//  MenuCollectionViewCell.swift
//  bex_hw
//
//  Created by Nurpeiis Bexultan on 28.05.2022.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MenuCollectionViewCell"
    private var oldValue: Double = 0
    private var model: Menu?
    
    private let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(14)
        label.textAlignment = .left
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            secondStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let stepper: UIStepper = {
        let stepper = UIStepper(frame: CGRect(x: 100, y: 200, width: 0, height: 0))
//        stepper.wraps = true
        stepper.autorepeat = true
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        return stepper
    }()
    
    private let valueNumber: UILabel = {
        let label = UILabel()
        label.text = "0 kg"
        return label
    }()
    
    
    private lazy var secondStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stepper, valueNumber])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let likeImageView: UIImageView = {
         let likeImageView = UIImageView(image: UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate))
         likeImageView.contentMode = .scaleAspectFit
         likeImageView.isUserInteractionEnabled = true
         return likeImageView
     }()
    
    private let bonusLabel: UILabel = {
        let label = UILabel()
        label.text = "20% для friends"
        label.backgroundColor = .yellow
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
        setUpLayouts()
        oldValue = stepper.value
    }
       
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setUpLayouts(){
        contentView.addSubview(cellImage)
        cellImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.left.equalToSuperview()
            $0.height.equalTo(150)
            $0.width.equalTo(150)
        }
        cellImage.addSubview(likeImageView)
        likeImageView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(10)
        }
        cellImage.addSubview(bonusLabel)
        bonusLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(5)
        }
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(cellImage.snp.bottom).offset(5)
            $0.left.equalToSuperview().inset(10)
        }
    }
    
    @objc private func stepperValueChanged(_ stepper: UIStepper){
        if (stepper.value > oldValue) {
            oldValue = oldValue + 1
            //Your Code You Wanted To Perform On Increment
            
            let totalPrice = (model?.price ?? 0) * Int(stepper.value)
            subtitleLabel.text = String(totalPrice) + " тг"
            if OrdersList.shared.basketList.contains(where: { $0.menu?.id == model?.id }) {
                if let index = OrdersList.shared.basketList.firstIndex(where: { $0.menu?.id == model?.id }) {
                    OrdersList.shared.basketList[index].count += 1
                }
            } else {
                OrdersList.shared.basketList.append(Basket(menu: model, count: Int(stepper.value)))
            }
        }
        else {
             oldValue = oldValue - 1
             //Your Code You Wanted To Perform On Decrement
            let totalPrice = (model?.price ?? 0) * Int(stepper.value)
            subtitleLabel.text = String(totalPrice) + " тг"
            if OrdersList.shared.basketList.contains(where: { $0.menu?.id == model?.id }) {
                if let index = OrdersList.shared.basketList.firstIndex(where: { $0.menu?.id == model?.id }) {
                    if OrdersList.shared.basketList[index].count > 0 {
                        OrdersList.shared.basketList[index].count -= 1
                    } else {
                        OrdersList.shared.basketList.removeAll(where: { $0.menu?.id == model?.id })
                    }
                }
            }
        }
        valueNumber.text = String(Int(stepper.value)) + " kg"
    }
    
    func configure(with items: Menu){

        self.model = items
        
        cellImage.image = items.image
        titleLabel.text = items.title
        subtitleLabel.text = String(Int(stepper.value) * items.price) + " тг"
    }
}
