//
//  CartModel.swift
//  FakeShop
//
//  Created by anita on 30.06.2022.
//

import Foundation

class CartResponseElement: Codable {
    let id, userID: Int
    let date: String
    let products: [Product]
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case date, products
        case v = "__v"
    }

    init(id: Int, userID: Int, date: String, products: [Product], v: Int) {
        self.id = id
        self.userID = userID
        self.date = date
        self.products = products
        self.v = v
    }
}
// MARK: - Product
 class Product: Codable {
    let productID, quantity: Int

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case quantity
    }

    init(productID: Int, quantity: Int) {
        self.productID = productID
        self.quantity = quantity
    }
}

typealias CartResponse = [CartResponseElement]

