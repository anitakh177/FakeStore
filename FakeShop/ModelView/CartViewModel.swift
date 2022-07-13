//
//  CartViewModel.swift
//  FakeShop
//
//  Created by anita on 12.07.2022.
//

import Foundation

struct CartModelView {
    let name: String
    let price: Double
    let image: String
    let total: Double
    
    init(with product: Products) {
        name = product.title
        price = product.price
        image = product.image
        total = 0.0
    }
}



