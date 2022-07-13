//
//  CartFooterView.swift
//  FakeShop
//
//  Created by anita on 13.07.2022.
//

import UIKit

class CartFooterView: UIView {
    
    private lazy var cartFooterView: UIView = {
        let footerView = UIView()
        footerView.backgroundColor = .gray
        return footerView
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.textAlignment = .left
        
        return label
    }()
    
     lazy var totalSumLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var totalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [totalLabel, totalSumLabel])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        
        return stack
    }()
    
    private func setupView() {
        addSubview(cartFooterView)
        cartFooterView.addSubview(totalStack)
        cartFooterView.translatesAutoresizingMaskIntoConstraints = false
        totalStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           cartFooterView.heightAnchor.constraint(equalTo: heightAnchor),
           cartFooterView.widthAnchor.constraint(equalTo: widthAnchor),
           
           totalStack.widthAnchor.constraint(equalTo: cartFooterView.widthAnchor),
           totalStack.centerXAnchor.constraint(equalTo: centerXAnchor),
           totalStack.topAnchor.constraint(equalTo: cartFooterView.topAnchor, constant: 5),
        ])
    }
    
    // MARK: - Initilization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configureTotal(for total: CartManager) {
        totalSumLabel.text = String(total.total)
    }
}
