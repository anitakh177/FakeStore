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
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
     let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.backgroundColor = .green
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.backgroundColor = .green
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
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
      /*  myLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-50, width: contentView.frame.size.width-10, height: 50 )
        myImageView.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width-10, height: contentView.frame.size.height-50)
        
    */
        titleLabel.frame = CGRect(x: 20, y: contentView.frame.size.height-55, width: 110, height: 20)
        priceLabel.frame = CGRect(x: 20, y: contentView.frame.size.height-30, width: 110, height: 20)
        myImageView.frame = CGRect(x: 20, y: 15, width: 110, height: 140)
    }
    
    public func configure(for result: Product) {
        titleLabel.text = result.title
        priceLabel.text = String(format: "%d", result.price)
        
        myImageView.image = UIImage(systemName: "square")
        if let imageURL = URL(string: result.image) {
            downloadTask = myImageView.loadImage(url: imageURL)
        }
    }
    
    // for diferent text in label
/*
    public func configure(label: String) {
        myLabel.text = label
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
 */

}

