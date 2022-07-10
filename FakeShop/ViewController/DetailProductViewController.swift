//
//  DetailProductViewController.swift
//  FakeShop
//
//  Created by anita on 17.06.2022.
//

import UIKit
import Combine

class DetailProductViewController: UIViewController, UIScrollViewDelegate {
   
    var cart = CartManager()
   
    
    var productResult: Products!
    
    var downloadTask: URLSessionDownloadTask?
    
    private let scrollView = UIScrollView()
    private let detailProductView = DetailProductView()
    private let mainStackView = UIStackView()
   
    //private let buttonStack = StickyButtons()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupMainStack()
        getBackButton()
    
        updateUI()
        setupButtons()
       
       
    }
    
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
            //mainStackView.heightAnchor.constraint(equalToConstant: 1000 )
        
        ])
        //setupDetailView()
   mainStackView.addArrangedSubview(detailProductView)
    }
 
    private func setupDetailView() {
        mainStackView.addArrangedSubview(detailProductView)
        detailProductView.translatesAutoresizingMaskIntoConstraints = false
        //detailProductView.heightAnchor.constraint(lessThanOrEqualToConstant: 1000).isActive = true
       // detailProductView.heightAnchor.constraint(lessThanOrEqualToConstant: 1000).isActive = true
       
        
    }
  
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
       
        
        view.addSubview(scrollView)
        //scrollView.backgroundColor = .green
        let frameLayoutGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
        
    }

    /*
    private func setupButtons() {
        scrollView.addSubview(buttonStack)
        buttonStack.backgroundColor = .yellow
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //buttonStack.widthAnchor.constraint(equalToConstant: 250),
            buttonStack.heightAnchor.constraint(equalToConstant: 50),
            buttonStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            buttonStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            buttonStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20)
        
        ])
    }
    */
    
    // MARK: Navigation
    let viewModel = CustomCartButton()
   // cartButton.configure(with: viewModel)

    func getBackButton() {
       let leftBarButton = navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem?.tintColor = .black
     //  let rightBarButton = navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(openCart))
        let button = navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonView)
        
       
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
        
    
        present(navVC, animated: true)
    }
   
    
    // MARK: UI
    func updateUI() {
        detailProductView.configure(for: productResult)
        
    }
    


// MARK: - Buttons Configuration


    private var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buy now", for: .normal)
        //button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.contentHorizontalAlignment = .left
        
        return button
    }()
    
    private let cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        
    
       button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        return button
    }()
   
    @objc func addToCart() {
        cart.addToCart(product: productResult)
        print(cart.total)
    }
    func updateCartVC(cart: CartManager) {
        
    }
    private func setupButtons() {
        let buttonStack = UIStackView()
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.alignment = .bottom
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fill
        //buttonStack.backgroundColor = .yellow
        buttonStack.addArrangedSubview(buyButton)
        buttonStack.addArrangedSubview(cartButton)
        
        view.addSubview(buttonStack)
        //let frameLayoutGuide = scrollView.frameLayoutGuide
        NSLayoutConstraint.activate([
            buttonStack.widthAnchor.constraint(equalTo: view.widthAnchor),
            //buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
           // buttonStack.heightAnchor.constraint(equalToConstant: 100),
           //buttonStack.leftAnchor.constraint(equalTo: frameLayoutGuide.leftAnchor),
           // buttonStack.rightAnchor.constraint(equalTo: frameLayoutGuide.rightAnchor),
           // buttonStack.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor, constant: -500)
            
        ])
      
        
    }
    
    
}

