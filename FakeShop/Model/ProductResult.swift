//
//  ProductResult.swift
//  FakeShop
//
//  Created by anita on 06.06.2022.
//

import Foundation

// MARK: - Product
struct Products: Codable {
    var id: Int16 = 0
    var title: String = ""
    var price: Double = 0
    var description: String = ""
    var category: Category?
    var image: String = ""
    var rating: Rating?
    
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

struct Rating: Codable {
    var rate: Double = 0.0
    var count: Int = 0
}
