//
//  PaymentViewController.swift
//  bex_hw
//
//  Created by Nurpeiis Bexultan on 28.05.2022.
//

import UIKit

class PaymentViewController: UIViewController {
    
    private let addressTitle: UILabel = {
        let label = UILabel()
        label.text = "Адресс доставки"
        return label
    }()
    
    private let currentAddress: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Текущий aдресс"
        textField.layer.cornerRadius = 12
        textField.backgroundColor = UIColor.white
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.textColor = UIColor(red: 0.058, green: 0.058, blue: 0.058, alpha: 1)
        return textField
    }()
    
    private let items: [Date] = [
        Date(date: "Сегодня"),
        Date(date: "30 мая"),
        Date(date: "31 мая"),
        Date(date: "1 июня"),
        Date(date: "2 июня"),
        Date(date: "3 июня"),
        Date(date: "4 июня"),
        Date(date: "5 июня"),
        Date(date: "6 июня"),
        Date(date: "7 июня")
    ]
    
    private let dateTitle: UILabel = {
        let label = UILabel()
        label.text = "Дата доставки"
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.register(
            PaymentCollectionViewCell.self,
                forCellWithReuseIdentifier: PaymentCollectionViewCell.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(
            top: 5,
            left: 10,
            bottom: 0,
            right: 10
        )
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemGray6
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.minimumLineSpacing = 10
        return collectionView
    }()
    
    private let contactTitle: UILabel = {
        let label = UILabel()
        label.text = "Контактная информация"
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя получателя"
        textField.layer.cornerRadius = 12
        textField.backgroundColor = UIColor.white
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.textColor = UIColor(red: 0.058, green: 0.058, blue: 0.058, alpha: 1)
        return textField
    }()
    
    private let numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Номер телеофна"
        textField.layer.cornerRadius = 12
        textField.backgroundColor = UIColor.white
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.textColor = UIColor(red: 0.058, green: 0.058, blue: 0.058, alpha: 1)
        return textField
    }()

    private let list = ["Неспелый","Спелый","Уже сорван"]
    
    lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: list)
        control.selectedSegmentTintColor = .systemGreen
        control.layer.borderColor = UIColor.systemGreen.cgColor
        control.layer.borderWidth = 1
        control.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor:UIColor.white],
            for: UIControl.State.selected)
        control.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor:UIColor.systemGreen],
                                       for: UIControl.State.normal)
        return control
    }()
    
    
    private let arbuzTitle: UILabel = {
        let label = UILabel()
        label.text = "Порезать дольками"
        return label
    }()
    
    private let switchOn = UISwitch()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [arbuzTitle, switchOn])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let paymentTitle: UILabel = {
        let label = UILabel()
        label.text = "Оплата"
        return label
    }()
    
    private let dataPayemnt = ["Cash", "Card"]
    
    lazy var paymentPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    private let payButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Оплатить", for: .normal)
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.backgroundColor = .systemGreen
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(touchBtn), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Оформление заказа"
        setUpLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    private func setUpLayout(){
        view.addSubview(addressTitle)
        addressTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.equalToSuperview().inset(16)
        }
        
        view.addSubview(currentAddress)
        currentAddress.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.top.equalTo(addressTitle.snp.bottom).offset(12)
        }
        
        view.addSubview(dateTitle)
        dateTitle.snp.makeConstraints {
            $0.top.equalTo(currentAddress.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(16)
            $0.height.equalTo(60)
            $0.top.equalTo(dateTitle.snp.bottom).offset(12)
        }
        
        view.addSubview(contactTitle)
        contactTitle.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.top.equalTo(contactTitle.snp.bottom).offset(12)
        }
        
        view.addSubview(numberTextField)
        numberTextField.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.top.equalTo(nameTextField.snp.bottom).offset(12)
        }
        
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(numberTextField.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(16)
        }
        
        view.addSubview(paymentTitle)
        paymentTitle.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
        }
        
        view.addSubview(paymentPicker)
        paymentPicker.snp.makeConstraints {
            $0.top.equalTo(paymentTitle.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        view.addSubview(payButton)
        payButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(200)
        }
    }
    
    @objc private func touchBtn(){
        let alert = UIAlertController(title: "Заказ успешно оформлен!", message: "Ожидайте", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ждууу!!!", style: UIAlertAction.Style.default, handler: { alert in
            
            self.navigationController?.popViewController(animated: true)
        } ))
        self.present(alert, animated: true, completion: nil)
    }
}

extension PaymentViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PaymentCollectionViewCell.identifier,
            for: indexPath
        ) as! PaymentCollectionViewCell
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PaymentCollectionViewCell else {
                        return
                }
            cell.backgroundColor = .systemGreen
    }

}

extension PaymentViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

}

extension PaymentViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 3 * 100) / 1.2
        let height = width / 1.4
        return CGSize(width: width, height: height)
    }
}

extension PaymentViewController: UIPickerViewDelegate{
  
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataPayemnt[row]
    }
}

extension PaymentViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataPayemnt.count
    }
    
    
}
