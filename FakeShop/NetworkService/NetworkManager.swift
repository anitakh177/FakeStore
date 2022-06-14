//
//  NetworkManager.swift
//  FakeShop
//
//  Created by anita on 06.06.2022.
//

import Foundation
import UIKit

protocol NetworkManagerDelegate {
    func didSendProductData (_ productService: NetworkManager, with product: [Product])
}

class NetworkManager {
 
    
    private let url = URL(string: "https://fakestoreapi.com/products")
    
    private var dataTask: URLSessionDataTask?
    
     var delegate: NetworkManagerDelegate?
    
    func loadProducts() {
        URLSession.shared.dataTask(with: url!) {  data, response, error in
        if let error = error {
            print(error)
            return
        }
        guard let data = data else { return }
        do {
            var products = try JSONDecoder().decode([Product].self, from: data)
            products = self.parse(data: data)
            print(products)
            DispatchQueue.main.async {
                self.delegate?.didSendProductData(self, with: products)
            }
           
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

