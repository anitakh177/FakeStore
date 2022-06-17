//
//  MainView.swift
//  FakeShop
//
//  Created by anita on 07.06.2022.
//

import UIKit

class MainView: UIView {
    

    let nameText = "Hi, Anita!"
    
    // MARK: - Properties
    
    private lazy var greetingLabel: UILabel = {
        let label = PaddingLabel()
        label.text = nameText
        label.paddingTop = 5
        label.font = UIFont(name: "TamilSangamMN-Bold", size: 22)
        return label
    }()
    
   private lazy var textLabel: UILabel = {
        let label = PaddingLabel()
        label.text = "New collection from Versace"
        label.font = UIFont(name: "TamilSangamMN-Bold", size: 20)
        label.textColor = .systemGray
        label.paddingTop = 9
        label.paddingBottom = 7
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "versche")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
    
        return imageView
    }()
    
   
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [greetingLabel, textLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelsStackView, imageView])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    
    func setupStackView() {
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           // mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        
        ])
    }
}


