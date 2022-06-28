//
//  StickyButtons.swift
//  FakeShop
//
//  Created by anita on 27.06.2022.
//

import UIKit
/*
class StickyButtons: UIView {
    
    private let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buy now", for: .normal)
        return button
    }()
    private let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        return button
    }()
   
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [buyButton, cartButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    
    func setupButtons() {
       addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        buttonStack.centerXAnchor.constraint(equalTo: centerXAnchor),
        buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
        buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        buttonStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
      
   }
   
}

*/
