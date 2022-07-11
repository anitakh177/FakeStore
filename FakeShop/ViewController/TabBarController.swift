//
//  TabBarController.swift
//  FakeShop
//
//  Created by anita on 11.07.2022.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let mainVC = MainViewController()
        let mainVCBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        
        mainVC.tabBarItem = mainVCBarItem
        
        let favVC = FavoriteViewController()
        let favVCBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        favVC.tabBarItem = favVCBarItem
        
        self.viewControllers = [mainVC, favVC]
    }
   
}

