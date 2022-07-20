//
//  ButtonView.swift
//  FakeShop
//
//  Created by anita on 11.07.2022.
//

import UIKit

class DetailButtonView: UIView {
    
    private var buttonView: UIView = {
      let butView = UIView()
        //butView.backgroundColor = .system
        return butView
    }()
    
    private var separatorLine: UILabel = {
        let separator = UILabel()
        separator.backgroundColor = .systemFill
            return separator
        }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private func setupView() {
        addSubview(buttonView)
        buttonView.addSubview(separatorLine)
        buttonView.addSubview(priceLabel)
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonView.heightAnchor.constraint(equalToConstant: 70),
            buttonView.widthAnchor.constraint(equalTo: widthAnchor),
            
            separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
            separatorLine.widthAnchor.constraint(equalTo: buttonView.widthAnchor),
            separatorLine.topAnchor.constraint(equalTo: buttonView.topAnchor),
            
            priceLabel.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -2)
            
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
}
