//
//  PaymentCollectionViewCell.swift
//  bex_hw
//
//  Created by Abylbek Khassenov on 29.05.2022.
//

import UIKit

class PaymentCollectionViewCell: UICollectionViewCell {
    static let identifier = "PaymentCollectionViewCell"
    
    private let date: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 30
        setup()
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
    
    private func setup(){
        contentView.addSubview(date)
        date.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5
            )
        }
    }
    
    func configure(with items: Date){
        date.text = items.date
    }
}
