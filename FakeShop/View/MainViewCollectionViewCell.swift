//
//  MainViewCollectionViewCell.swift
//  FakeShop
//
//  Created by anita on 08.06.2022.
//

import UIKit

class MainViewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionView"
    var downloadTask: URLSessionDownloadTask?
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = .gray
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: "Thonburi-Light", size: 13)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(myImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 20, y: contentView.frame.size.height-100, width: 110, height: 70)
        priceLabel.frame = CGRect(x: 20, y: contentView.frame.size.height-20, width: 110, height: 15)
        myImageView.frame = CGRect(x: 20, y: 15, width: 110, height: 140)
    }
    
    public func configure(for result: Product) {
        titleLabel.text = result.title
        priceLabel.text = ("\(String(format: "%.2f", result.price)) $")
        
        myImageView.image = UIImage(systemName: "square")
        myImageView.tintColor = .gray
        if let imageURL = URL(string: result.image) {
            downloadTask = myImageView.loadImage(url: imageURL)
        }
    }
    
    // for diferent text in label

    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        priceLabel.text = nil
        myImageView.image = nil
    }
 

}

