//
//  SignUpView.swift
//  FakeShop
//
//  Created by anita on 21.07.2022.
//

import UIKit

class SignUpView: UIView {
    
     let signUpLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Sign Up"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
     let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        return textField
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        return textField
    }()
    
     let emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
         textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        return textField
    }()
    
    let passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        return textField
    }()
    
     let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        //button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        return button
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "Error occured"
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [signUpLabel,firstNameTextField, lastNameTextField, emailField, passwordField, signUpButton, errorLabel])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillProportionally
        
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
      addSubview(stack)
      stack.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
        stack.centerXAnchor.constraint(equalTo: centerXAnchor),
        stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
        stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
        stack.topAnchor.constraint(equalTo: topAnchor),
        stack.heightAnchor.constraint(equalTo: heightAnchor)
      ])
        
       
}
}
