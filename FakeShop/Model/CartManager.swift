//
//  CartManager.swift
//  FakeShop
//
//  Created by anita on 01.07.2022.
//

import Foundation
protocol Subject {
    func addToCart(product: Products)
    func removeFromCart(product: Products)
    
}
// chages in this class will be updated in the ui
class CartManager: Subject {
    
    var products: [Products] = []
    private(set) var total: Double = 0.0
    
    func addToCart(product: Products) {
        products.append(product)
        total += product.price
    }
    
    func removeFromCart(product: Products) {
        products = products.filter{ $0.id != product.id }
        total -= product.price
    }
}
