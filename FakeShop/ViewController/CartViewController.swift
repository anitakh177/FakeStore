//
//  CartViewController.swift
//  FakeShop
//
//  Created by anita on 01.07.2022.
//

import UIKit

class CartViewController: UIViewController {
    
    private var productTableView: UITableView = {
        let tabel = UITableView()
        tabel.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
        tabel.delegate = self
        table.dataSource = self
    }()
}
