//
//  ButtonView.swift
//  FakeShop
//
//  Created by anita on 11.07.2022.
//

import UIKit

class ButtonView: UIView {
    
    private var buttonView: UIView = {
      let butView = UIView()
        butView.backgroundColor = .systemGray
        return butView
    }()
    
    private func setupView() {
        addSubview(buttonView)
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonView.heightAnchor.constraint(equalToConstant: 70),
            buttonView.widthAnchor.constraint(equalTo: widthAnchor),
            
        
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
