//
//  NetworkManager.swift
//  FakeShop
//
//  Created by anita on 06.06.2022.
//

import Foundation

class Network {
    var productResults = [Product]()
    
    
    let url = URL(string: "https://fakestoreapi.com/products")

    func loadProducts() {
        URLSession.shared.dataTask(with: url!) { data, response, error in
        if let error = error {
            print(error)
            return
        }
        guard let data = data else { return }
        do {
       let products = try JSONDecoder().decode([Product].self, from: data)
            self.productResults = self.parse(data: data)
            print(products)
        } catch {
            print(error)
        }
    }.resume()
   
    }
    
    func parse(data: Data) -> [Product] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode([Product].self, from: data)
            return result
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }
}

