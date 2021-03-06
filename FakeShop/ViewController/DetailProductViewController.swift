//
//  DetailProductViewController.swift
//  FakeShop
//
//  Created by anita on 17.06.2022.
//

import UIKit
import Combine
import CoreData

class DetailProductViewController: UIViewController {
    
    var cart = CartManager()
    var productResult: Products!
    
   
    lazy var coreDataStack = CoreDataStack(modelName: "ProductEntity")
    
    var downloadTask: URLSessionDownloadTask?
    
    private let scrollView = UIScrollView()
    private let mainStackView = UIStackView()
    private let detailProductView = DetailProductView()
    private let buttonView = DetailButtonView()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.tintColor = .black
    
        setupScrollView()
        setupMainStack()
        navigationButtons()

        updateUI()
        setupButtonView()
        showCount()
      
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
            frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75)
        ])
        
    }
    
    // MARK: Navigation
  
    private var badgeCount: UILabel = {
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
       
        rightBarButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        rightBarButton.addTarget(self, action: #selector(openCart), for: .touchUpInside)
        rightBarButton.addSubview(badgeCount)
        rightBarButton.tintColor = .black
    
        let rightBarButtomItem = UIBarButtonItem(customView: rightBarButton)
        navigationItem.rightBarButtonItem = rightBarButtomItem


       let leftBarButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissSelf))
        leftBarButton.tintColor = .black
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
        //let results = cart.products
        //cartVC.cartResult.products = results
       // let total = cart.total
        //cartVC.cartResult.total = total
        cartVC.coreDataStack = coreDataStack
    
        present(navVC, animated: true)
    }
   
    
    // MARK: UI
   private func updateUI() {
        detailProductView.configure(for: productResult)
       buttonView.priceLabel.text = "\(productResult.price)$"
    }
    
   private func setupButtonView() {
      view.addSubview(buttonView)
       buttonView.addSubview(cartButton)
      buttonView.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
        buttonView.heightAnchor.constraint(equalToConstant: 100),
        buttonView.widthAnchor.constraint(equalTo: view.widthAnchor),
        buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        cartButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
        cartButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 5),
        cartButton.leftAnchor.constraint(equalTo: buttonView.leftAnchor, constant: 10),
        cartButton.rightAnchor.constraint(equalTo: buttonView.rightAnchor, constant: -10),
        cartButton.heightAnchor.constraint(equalToConstant: 40)
      ])
       
       
      //setupButtons()
    }
// MARK: - Helper Methods
    
    func populateCountLabel() {
        let fetchRequest = NSFetchRequest<NSNumber>(entityName: "ProductEntity")
        fetchRequest.resultType = .countResultType
     
        do {
            let countResult = try coreDataStack.managedContext.fetch(fetchRequest)
            
            let count = countResult.first?.intValue ?? 0
            badgeCount.text = "\(count)"
        } catch let error as NSError {
            print("count not fetched \(error), \(error.userInfo)")
        }
    }
    
    private func fetchProducts() {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        coreDataStack.managedContext.perform {
            do {
                let results = try fetchRequest.execute()
                self.badgeCount.text = "\(results.count)"
                
            } catch {
                print("Unable to Execute Fetch Request, \(error)")
            }
        }
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
        button.setTitle("Add To Cart", for: .normal)
        //button.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
    
        button.titleLabel?.textColor = .white
        button.tintColor = .white
        button.backgroundColor = .black
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
    
        button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    
        return button
    }()
   
    @objc func addToCart() {
       // cart.addToCart(product: productResult)
        
        let product = ProductEntity(context: self.coreDataStack.managedContext)
        product.name = productResult.title
        product.price = productResult.price
        product.productDescription = productResult.description
        product.image = productResult.image
        product.productID = productResult.id
    
        self.coreDataStack.saveData()
    }
    
   
    func showCount() {
        populateCountLabel()
        NotificationCenter.default.addObserver(forName: .NSManagedObjectContextObjectsDidChange, object: coreDataStack.managedContext, queue: .main) { [weak self] _ in
            self?.fetchProducts()
        }
       
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private func setupButtons() {
        let buttonStack = UIStackView()
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillProportionally
        buttonStack.alignment = .center
        buttonStack.spacing = 20
    
        buttonStack.addArrangedSubview(buyButton)
        buttonStack.addArrangedSubview(cartButton)
        
        buttonView.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            buttonStack.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            buttonView.widthAnchor.constraint(equalTo: buttonView.widthAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -45)
        ])
    }
    
}

