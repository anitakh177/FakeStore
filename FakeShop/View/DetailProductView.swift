//
//  DetailProductView.swift
//  FakeShop
//
//  Created by anita on 17.06.2022.
//

import UIKit

class DetailProductView: UIView {
    
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.textAlignment = .left
        label.font = UIFont(name: "Thonburi-Bold", size: 17)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    
    func setupDetails() {
        
        
    }
    
}
