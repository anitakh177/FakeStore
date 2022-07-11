//
//  ViewController.swift
//  FakeShop
//
//  Created by anita on 06.06.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    
    // MARK: Propeties
    private var mainView = MainView()
    private var mainStackView = UIStackView()
    private var scrollView = UIScrollView()
  
    private var networkManager = NetworkManager()
    private var productResults = [Products]()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        //flowLayout.minimumLineSpacing = 15
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.itemSize = CGSize(width: 150, height: 260)
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainViewCollectionViewCell.self, forCellWithReuseIdentifier: MainViewCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.alwaysBounceHorizontal = true
       // collectionView.backgroundColor = .red
        
        return collectionView
    }()
    
   private lazy var segmentedControl: UISegmentedControl = {
        var control = UISegmentedControl(items: ["All", "Men", "Women", "Jewelery", "Electro"])
        control.selectedSegmentTintColor = .black
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        control.tintColor = .white
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentChanged(_ :)), for: .valueChanged)
        return control
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Fake Store"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupScrollView()
        setupMainStackView()
        setupCollectionView()
        performSearch()
        
         showButton()
        navigationBar()
        
      
      
    }
    
    // MARK: - Tab Bar
    
    private func createTabBar() {
        let tabBarVC = UITabBarController()
        
        let vc1 = MainViewController()
        let vc2 = FavoriteViewController()
        
        tabBarVC.setViewControllers([vc1, vc2], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
    
    // MARK: - Helper Methods
    
    func performSearch() {
        if let category = NetworkManager.Category(rawValue: segmentedControl.selectedSegmentIndex) {
            networkManager.loadProducts(category: category) { [weak self] products in
                guard let products = products else { return }
                self?.productResults = products
                self?.collectionView.reloadData()
            }
        }
      
    }
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        performSearch()

    }
    // MARK: - Navigation
    
    func navigateToDeatilVC(with indexPath: IndexPath) {
        let detailVC = DetailProductViewController()
        let navVC = UINavigationController(rootViewController: detailVC)
        navVC.modalPresentationStyle = .fullScreen
        let results = productResults[indexPath.row]
        detailVC.productResult = results
        
        
        present(navVC, animated: true)
    }
    
    private func navigationBar() {
        let rightBarButtonitem = UIBarButtonItem(image: UIImage(systemName: "bag"), style: .plain, target: self, action: nil)
        rightBarButtonitem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonitem
    }
  
 
    // MARK: - Alert message
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Layout
    private func setupProfileHeaderView() {
      mainStackView.addArrangedSubview(mainView)
      mainView.translatesAutoresizingMaskIntoConstraints = false
      mainView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    private func setupSegmantedControll() {
         mainStackView.addArrangedSubview(segmentedControl)
         segmentedControl.translatesAutoresizingMaskIntoConstraints = false

     }
    
    private func setupMainStackView() {
      mainStackView.axis = .vertical
      mainStackView.distribution = .fill
      mainStackView.spacing = 10
      mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(mainStackView)
        let contentLayoutGuide = scrollView.contentLayoutGuide

      NSLayoutConstraint.activate([
        //3
        mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        mainStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
        mainStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
        mainStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor, constant: 0),
      ])
      
        setupProfileHeaderView()
        setupSegmantedControll()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let frameLayoutGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

     private func setupCollectionView() {
        scrollView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
         let contentLayoutGuide = scrollView.contentLayoutGuide
         
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor, constant: -50),
            collectionView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20),
            collectionView.heightAnchor.constraint(equalToConstant: 270)
        ])
    }
    
    private func showButton() {
        
        let button = UIButton()
        button.setTitle("Show all products", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 23
        button.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(button)
        
        let frameLayoutGuide = scrollView.frameLayoutGuide
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 250),
            button.heightAnchor.constraint(equalToConstant: 45),
            button.bottomAnchor.constraint(equalTo: frameLayoutGuide.bottomAnchor, constant: -5)
        
        ])
        
        button.addTarget(self, action: #selector(showAll), for: .touchUpInside)
         
    }
    @objc func showAll() {
        let allProductsVC = AllProductsViewController()
        let navVC = UINavigationController(rootViewController: allProductsVC)
        navVC.modalPresentationStyle = .fullScreen
        let results = productResults
        allProductsVC.productResults = results
        
        present(navVC, animated: true)
    }
    
}


// MARK: - Data Source
extension MainViewController: UICollectionViewDataSource {
    
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
// MARK: - Delegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToDeatilVC(with: indexPath)
        _ = productResults[indexPath.row]
    }
}

