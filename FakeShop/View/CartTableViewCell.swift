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
    
    let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .gray
        return imageView
    }()
    
     let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.clipsToBounds = true
        label.textAlignment = .left
        label.font = UIFont(name: "GeezaPro", size: 17)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
     let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = UIFont(name: "GeezaPro-Bold", size: 20)
        label.clipsToBounds = true
        label.textAlignment = .left
        return label
    }()
    
    let stepper: UIStepper = {
        let stepper = UIStepper()
        
        return stepper
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.backgroundColor = .blue
        contentView.addSubview(myImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(stepper)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myImageView.frame = CGRect(x: 5, y: 5, width: 100, height: 120)
        titleLabel.frame = CGRect(x: 20+myImageView.frame.size.width, y: 0, width: 250, height: 70)
        priceLabel.frame = CGRect(x: 20+myImageView.frame.size.width, y: 30+titleLabel.frame.size.height, width: 110, height: 25)
        stepper.frame = CGRect(x: 150+priceLabel.frame.size.width, y: 30+titleLabel.frame.size.height, width: 110, height: 25)
    }
    
   public func configureCart(for result: Products) {
        titleLabel.text = result.title
        priceLabel.text = ("\(String(format: "%.2f", result.price)) $")
        
        myImageView.image = UIImage(systemName: "square")
        myImageView.tintColor = .gray
        if let imageURL = URL(string: result.image) {
            downloadTask = myImageView.loadImage(url: imageURL)
        }
    }
    
  /* public func configureCart( with viewModel: CartModelView) {
        titleLabel.text = viewModel.name
        priceLabel.text = "\(viewModel.price)"
        
        myImageView.image = UIImage(systemName: "square")
        myImageView.tintColor = .gray
        if let imageURL = URL(string: viewModel.image) {
            downloadTask = myImageView.loadImage(url: imageURL)
        
        }
    } */
}
