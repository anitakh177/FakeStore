//
//  NetworkManager.swift
//  FakeShop
//
//  Created by anita on 06.06.2022.
//

import Foundation
import UIKit

class NetworkManager {
 
    private var dataTask: URLSessionDataTask?
    
   enum Category: Int {
         case all = 0
         case menSClothing = 1
         case womenSClothing = 2
         case electronics = 4
         case jewelery = 3
        
        var type: String {
            switch self {
            case .all: return ""
            case .menSClothing: return "category/men's%20clothing"
            case .womenSClothing: return "category/women's%20clothing"
            case .electronics: return "category/electronics"
            case .jewelery: return "category/jewelery"
            }
        }
    }
    private func fakeStoreURL(category: Category) -> URL {
        let kind = category.type
        let url = URL(string: "https://fakestoreapi.com/products/" + "\(kind)")
        return url!
    }
   
    
    func loadProducts(category: Category, completion: @escaping(([Products]?) -> ())) {
        
        let url = fakeStoreURL(category: category)
        
        URLSession.shared.dataTask(with: url) {  data, response, error in
        if let error = error {
            print(error)
            completion(nil)
            return
        }
        guard let data = data else { return }
        do {
            var products = try JSONDecoder().decode([Products].self, from: data)
            products = self.parse(data: data)
            //print(products)
            DispatchQueue.main.async {
                completion(products)
            }
           
        } catch {
            print(error)
            completion(nil)
        }
    }.resume()
   
    }
    
  private func parse(data: Data) -> [Products] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode([Products].self, from: data)
            return result
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }
}
extension UIImageView {
    func loadImage(url: URL) -> URLSessionDownloadTask {
        
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url) {
            [weak self] url, _, error in
            if error == nil, let url = url,
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let weakSelf = self {
                        weakSelf.image = image
                    }
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}

