//
//  ViewController.swift
//  bex_hw
//
//  Created by Nurpeiis Bexultan on 27.05.2022.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {
    
    // MARK: - VARIABLES
//    var listOfOrders
    
    private let items: [Menu] = [
        Menu(id: 1, image: UIImage(named: "arbuz2"), title: "Арбуз с Шымкента", price: 1600),
        Menu(id: 2, image: UIImage(named: "arb"), title: "Арбуз от Arbuz.kz", price: 2000)
    ]
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
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
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.minimumLineSpacing = 10
        collectionView.backgroundColor = .systemGray6
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        collectionView.register(
            MenuCollectionViewCell.self,
                forCellWithReuseIdentifier: MenuCollectionViewCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        setUpNavBar()
        setUpLayouts()
    }
    
    private func setUpNavBar(){
        let img = UIImage.init(named: "arbuz")
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 150))
        imgView.image = img!
        imgView.contentMode = .scaleAspectFit
        let item = UIBarButtonItem.init(customView: imgView)
        let negativeSpacer = UIBarButtonItem.init(
            barButtonSystemItem: .fixedSpace,
            target: nil,
            action: nil
        )
        navigationItem.leftBarButtonItems = [item]
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .search)
    }

    private func setUpLayouts(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.right.left.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(collectionView.snp_width)
        }
    }
}

extension MenuViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuCollectionViewCell.identifier,
            for: indexPath
        ) as! MenuCollectionViewCell
        cell.configure(with: item)
        return cell
    }
}

extension MenuViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

}

extension MenuViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 3 * 10) / 2
        let height = width * 1.3
        return CGSize(width: width, height: height)
    }
}
