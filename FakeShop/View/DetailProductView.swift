//
//  DetailProductView.swift
//  FakeShop
//
//  Created by anita on 17.06.2022.
//

import UIKit

class DetailProductView: UIView {
    
    var downloadTask: URLSessionDownloadTask?
    
    
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 30, height: 30))
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 270).isActive = true
      
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0$"
        label.textAlignment = .right
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [productImage])
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    private lazy var titleAndPriceStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ priceLabel])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        //stack.alignment = .center
        return stack
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textColor = .darkGray
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        label.textAlignment = .left
        return label
    }()
    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textAlignment = .right
        return label
    }()
    
    private lazy var categoryStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [categoryLabel, categoryNameLabel])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
  
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.numberOfLines = 0
        return label
    }()
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "5.0"
        label.textAlignment = .right
        return label
    }()
    
    private lazy var rateCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        //label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 17)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var ratingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Rating"
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ratingTitleLabel, ratingLabel])
        stack.distribution = .fill
        stack.axis = .horizontal
        return stack
    }()
    private lazy var rateStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ratingStackView, rateCountLabel])
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageStackView, titleLabel, categoryStackView, descriptionLabel, rateStackView, priceLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 20
        return stack
    }()
    
    // MARK: - Initilization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  public func setupStackView() {
        
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
       NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.heightAnchor.constraint(equalTo: heightAnchor)
           ])
            
            }
  
    public func configure(for result: Products) {
        titleLabel.text = result.title
        priceLabel.text = ("\(String(format: "%.2f", result.price)) $")
        descriptionLabel.text = result.description
        categoryNameLabel.text = "\(result.category!.rawValue)"
        ratingLabel.text = ("\(String(format: "%.1f", result.rating!.rate)) out of 5")
        rateCountLabel.text = ("\(String(format: "%d", result.rating!.count)) rated")
        if let imagURL = URL(string: result.image) {
            downloadTask = productImage.loadImage(url: imagURL)
    }
 }
}
