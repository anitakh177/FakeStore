//
//  DetailProductViewController.swift
//  FakeShop
//
//  Created by anita on 17.06.2022.
//

import UIKit

class DetailProductViewController: UIViewController {
    
    var productResult: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getBackButton()
    }
    
    // MARK: Navigation
    
    func getBackButton() {
       let leftBarButton = navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        
    }
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UI
    
    
    
}
