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
    
   private lazy var productsCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Amount"
        return label
    }()
    
    lazy var totalAmountOfProducts: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
  private  lazy var totalProducts: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [productsCount, totalAmountOfProducts])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private func setupView() {
        addSubview(cartFooterView)
        cartFooterView.addSubview(totalStack)
        cartFooterView.addSubview(totalProducts)
        cartFooterView.translatesAutoresizingMaskIntoConstraints = false
        totalStack.translatesAutoresizingMaskIntoConstraints = false
        totalProducts.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           cartFooterView.heightAnchor.constraint(equalTo: heightAnchor),
           cartFooterView.widthAnchor.constraint(equalTo: widthAnchor),
           
           totalStack.centerXAnchor.constraint(equalTo: centerXAnchor),
           totalStack.leadingAnchor.constraint(equalTo: cartFooterView.leadingAnchor, constant: 10),
           totalStack.trailingAnchor.constraint(equalTo: cartFooterView.trailingAnchor, constant: -10),
           totalStack.topAnchor.constraint(equalTo: cartFooterView.topAnchor, constant: 5),
           
           totalProducts.leadingAnchor.constraint(equalTo: cartFooterView.leadingAnchor, constant: 10),
           totalProducts.trailingAnchor.constraint(equalTo: cartFooterView.trailingAnchor, constant: -10),
           totalProducts.centerXAnchor.constraint(equalTo: centerXAnchor),
           totalProducts.topAnchor.constraint(equalTo: totalStack.bottomAnchor, constant: 10)
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
