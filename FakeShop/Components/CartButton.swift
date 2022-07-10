//
//  CartButton.swift
//  FakeShop
//
//  Created by anita on 06.07.2022.
//

import UIKit

struct CustomCartButtonViewModel {
    let numberOfProducts: Int
    let imageName: String
    
}

class CustomCartButton: UIButton {
    
    private let productCountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
     
    private var viewModel: CustomCartButtonViewModel?
    
    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    
    init(with viewModel: CustomCartButtonViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        addSubviews()
        configure(with: viewModel)
    }
    
    private func addSubviews() {
        guard !iconView.isDescendant(of: self) else {
            return
        }
        addSubview(iconView)
        addSubview(productCountLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: CustomCartButtonViewModel) {
        productCountLabel.text = String("\(viewModel.numberOfProducts)")
        iconView.image = UIImage(systemName: viewModel.imageName)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconView.frame = CGRect(x: 5, y: 5, width: 10, height: frame.height).integral
        productCountLabel.frame = CGRect(x: 5, y: 5, width: 3, height: 6)
    }
}
