//
//  MenuCollectionViewCell.swift
//  bex_hw
//
//  Created by Abylbek Khassenov on 28.05.2022.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "MenuCollectionViewCell"
    
    
    private let cellImage: UIImageView = {
        let imageView = UIImageView()
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
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, stepper, valueNumber])
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
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 20
        
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        return stepper
    }()
    
    private let valueNumber: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
    
        setUpLayouts()
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
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(cellImage.snp.bottom).offset(5)
            $0.left.equalToSuperview().inset(1)
        }
    
    }
    
    @objc private func stepperValueChanged(_ stepper: UIStepper){
        print("Chnaged Value: \(stepper.value)")
          stepper.stepValue = 1
          print("Chnaged Value: \(stepper.value)")
        valueNumber.text = String(Int(stepper.value))
        
    }
    
    public func configure(with items: Menu){
        cellImage.image = items.image
        titleLabel.text = items.title
        subtitleLabel.text = items.subtitle
    }
}
