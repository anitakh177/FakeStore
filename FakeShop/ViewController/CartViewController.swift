//
//  CartViewController.swift
//  FakeShop
//
//  Created by anita on 01.07.2022.
//

import UIKit

protocol AddProduct: AnyObject {
    func updateCartVC(cart: CartManager)
}

class CartViewController: UIViewController, UITableViewDataSource{
   
    weak var delegate: AddProduct?
    var cartResult = CartManager()
    
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
        print(cartResult.products)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func getBack() {
       let leftBarButton = navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartResult.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.idetifier, for: indexPath) as! CartTableViewCell
        let listOfProduct = cartResult.products[indexPath.row]
        cell.configureCart(for: listOfProduct)
       
        return cell
    }
    
    
}
