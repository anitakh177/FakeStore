//
//  CartViewController.swift
//  FakeShop
//
//  Created by anita on 01.07.2022.
//

import UIKit
import CoreData

class CartViewController: UIViewController, NSFetchedResultsControllerDelegate {
    var downloadTask: URLSessionDownloadTask?
   
    lazy var coreDataStack = CoreDataStack(modelName: "ProductEntity")
    var cartResult = CartManager()
   
    
    private var cartFooterView = CartFooterView()
    private var cartCell = CartTableViewCell()
    
    lazy var fetchedResultsController: NSFetchedResultsController<ProductEntity> = {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.idetifier)
        table.rowHeight = 140
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.reloadData()
        getBack()
        setupFooterView()
        showTotal()
        cartStepper()
    }
    
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-100))
        
    }
    private func cartStepper() {
        cartCell.stepper.addTarget(self, action: #selector(changeValueStepper), for: .valueChanged)
    }
    @objc func changeValueStepper(_ sender:UIStepper!) {
        displayTotal(number: cartResult.total)
        displayCartCount(number: cartResult.products.count)
        print("UIStepper is now \(Int(sender.value))")
        
    }
    private func setupFooterView() {
        view.addSubview(cartFooterView)
        cartFooterView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cartFooterView.heightAnchor.constraint(equalToConstant: 100),
            cartFooterView.widthAnchor.constraint(equalTo: view.widthAnchor),
            cartFooterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cartFooterView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
   
    func getBack() {
        _ = navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}


extension CartViewController: UITableViewDataSource ,CartViewManagerDelegate, CartManagerShowTotalDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartResult.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.idetifier, for: indexPath) as! CartTableViewCell
        let listOfProduct = cartResult.products[indexPath.row]
       cell.configureCart(for: listOfProduct)
        //cell.configureCart(with: CartModelView(with: listOfProduct))
        return cell
    }
     func displayTotal(number: Double) {
        cartFooterView.totalSumLabel.text = "\(number)$"
        
    }
   
    private func showTotal() {
        displayTotal(number: cartResult.total)
        displayCartCount(number: cartResult.products.count)
       
    }
    func displayCartCount(number: Int) {
        cartFooterView.totalAmountOfProducts.text = "\(number)"
    }
    
    
    
}

