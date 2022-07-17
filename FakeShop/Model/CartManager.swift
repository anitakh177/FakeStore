//
//  CartManager.swift
//  FakeShop
//
//  Created by anita on 01.07.2022.
//

import Foundation
import CoreData

protocol CartViewManagerDelegate {
    func displayCartCount(number: Int)
}
protocol CartManagerShowTotalDelegate {
    func displayTotal(number: Double)
}

class CartManager {
    var coreDataStack = CoreDataStack(modelName: "ProductEntity")
    
   // var cartProducts: [Products] = []
    var products: [Products] = []
    var total: Double = 0.0
    
    func addToCart(product: Products) {
        products.append(product)
        total += product.price
       
    }
    
    func removeFromCart(product: Products) {
        products = products.filter{ $0.id != product.id }
        total -= product.price
    }
}
