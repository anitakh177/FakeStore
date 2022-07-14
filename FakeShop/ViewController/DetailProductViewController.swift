//
//  DetailProductViewController.swift
//  FakeShop
//
//  Created by anita on 17.06.2022.
//

import UIKit
import Combine

class DetailProductViewController: UIViewController, CartViewManagerDelegate {
    
    var cart = CartManager()
    var productResult: Products!
    lazy var coreDataStack = CoreDataStack(modelName: "ProductEntity")
    
    var downloadTask: URLSessionDownloadTask?
    
    private let scrollView = UIScrollView()
    private let mainStackView = UIStackView()
    private let detailProductView = DetailProductView()
    private let buttonView = ButtonView()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.tintColor = .black
    
        setupScrollView()
        setupMainStack()
        navigationButtons()

        updateUI()
        setupButtonView()
       // setupButtons()
    
    }
    // MARK: Layout
    private func setupMainStack() {
        scrollView.addSubview(mainStackView)
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.alignment = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        let contentLayoutGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
        ])
            mainStackView.addArrangedSubview(detailProductView)
    }
  
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let frameLayoutGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
        
    }
    
    // MARK: Navigation
  
   // private func navigationButtons() {
     var badgeCount: UILabel = {
        let badgeCount = UILabel(frame: CGRect(x: 22, y: -05, width: 20, height: 20))
        badgeCount.layer.borderColor = UIColor.clear.cgColor
        badgeCount.layer.borderWidth = 2
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = badgeCount.font.withSize(12)
        badgeCount.backgroundColor = .red
        return badgeCount
    }()
    private func navigationButtons() {
        let rightBarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
       
        rightBarButton.setImage(UIImage(systemName: "cart"), for: .normal)
        rightBarButton.addTarget(self, action: #selector(openCart), for: .touchUpInside)
        rightBarButton.addSubview(badgeCount)
    
        let rightBarButtomItem = UIBarButtonItem(customView: rightBarButton)
        navigationItem.rightBarButtonItem = rightBarButtomItem


       let leftBarButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    @objc private func openCart() {
        let cartVC = CartViewController()
        let navVC = UINavigationController(rootViewController: cartVC)
        navVC.modalPresentationStyle = .fullScreen
        let results = cart.products
        cartVC.cartResult.products = results
        let total = cart.total
        cartVC.cartResult.total = total
    
        present(navVC, animated: true)
    }
   
    
    // MARK: UI
   private func updateUI() {
        detailProductView.configure(for: productResult)
    }
    
   private func setupButtonView() {
      view.addSubview(buttonView)
      buttonView.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
        buttonView.heightAnchor.constraint(equalToConstant: 100),
        buttonView.widthAnchor.constraint(equalTo: view.widthAnchor),
        buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
      setupButtons()
    }


// MARK: - Buttons Configuration

    private var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buy now", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.contentHorizontalAlignment = .left
        
        return button
    }()
    
    private let cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        
    
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    
        return button
    }()
   
    @objc func addToCart() {
        cart.addToCart(product: productResult)
        displayCartCount(number: cart.products.count)
       
        let product = ProductEntity(context: self.coreDataStack.managedContext)
        product.name = productResult.title
        product.price = productResult.price
        product.productDescription = productResult.description
        product.image = productResult.image
        product.productID = productResult.id
        self.coreDataStack.saveData()
        
        
    }
    func displayCartCount(number: Int) {
        badgeCount.text = "\(number)"
    }
    
    private func setupButtons() {
        let buttonStack = UIStackView()
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .horizontal
        buttonStack.distribution = .equalSpacing
    
        buttonStack.addArrangedSubview(buyButton)
        buttonStack.addArrangedSubview(cartButton)
        
        buttonView.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            buttonStack.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            buttonStack.widthAnchor.constraint(equalToConstant: 200),
            buttonStack.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -45)
        ])
    }
    
}

