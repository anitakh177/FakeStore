//
//  CartTableViewCell.swift
//  FakeShop
//
//  Created by anita on 01.07.2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    static let idetifier = "CartCell"
    var downloadTask: URLSessionDownloadTask?
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: "GeezaPro", size: 15)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = UIFont(name: "GeezaPro-Bold", size: 16)
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 20, y: contentView.frame.size.height-100, width: 110, height: 70)
        priceLabel.frame = CGRect(x: 20, y: contentView.frame.size.height-20, width: 110, height: 17)
        myImageView.frame = CGRect(x: 20, y: 15, width: 110, height: 140)
    }
    
    public func configure(for result: Products) {
        titleLabel.text = result.title
        priceLabel.text = ("\(String(format: "%.2f", result.price)) $")
        
        myImageView.image = UIImage(systemName: "square")
        myImageView.tintColor = .gray
        if let imageURL = URL(string: result.image) {
            downloadTask = myImageView.loadImage(url: imageURL)
        }
    }
}
