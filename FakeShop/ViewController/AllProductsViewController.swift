//
//  AllProductsViewController.swift
//  FakeShop
//
//  Created by anita on 21.06.2022.
//

import UIKit

class AllProductsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    var productResults = [Products]()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        //flowLayout.minimumLineSpacing = 15
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.itemSize = CGSize(width: 150, height: 260)
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainViewCollectionViewCell.self, forCellWithReuseIdentifier: MainViewCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
       // collectionView.backgroundColor = .red
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getBackButton()
    }
    
    private func setupCollectionView() {
       view.addSubview(collectionView)
       collectionView.translatesAutoresizingMaskIntoConstraints = false
       //collectionView.backgroundColor = .blue
       NSLayoutConstraint.activate([
           collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
           collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
           collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
       ])
   }
    
    func getBackButton() {
       let leftBarButton = navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCollectionViewCell.identifier, for: indexPath) as! MainViewCollectionViewCell
        let listOfProduct = productResults[indexPath.row]
          cell.configure(for: listOfProduct)
        return cell
    }
    
}
