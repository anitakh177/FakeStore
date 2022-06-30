//
//  DetailProductViewController.swift
//  FakeShop
//
//  Created by anita on 17.06.2022.
//

import UIKit

class DetailProductViewController: UIViewController, UIScrollViewDelegate {
    
    var productResult: Product!
    var downloadTask: URLSessionDownloadTask?
    
    private let scrollView = UIScrollView()
    private let detailProductView = DetailProductView()
    private let mainStackView = UIStackView()
   
    //private let buttonStack = StickyButtons()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupMainStack()
        getBackButton()
    
        updateUI()

    }
    
    private func setupMainStack() {
        scrollView.addSubview(mainStackView)
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        let contentLayoutGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
        
        ])
        //setupDetailView()
        mainStackView.addArrangedSubview(detailProductView)
    }
 
   /* private func setupDetailView() {
        mainStackView.addArrangedSubview(detailProductView)
        detailProductView.translatesAutoresizingMaskIntoConstraints = false
        detailProductView.heightAnchor.constraint(greaterThanOrEqualToConstant: 500).isActive = true
        
    }
  */
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
       
        
        view.addSubview(scrollView)
        //scrollView.backgroundColor = .green
        let frameLayoutGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }

    /*
    private func setupButtons() {
        scrollView.addSubview(buttonStack)
        buttonStack.backgroundColor = .yellow
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //buttonStack.widthAnchor.constraint(equalToConstant: 250),
            buttonStack.heightAnchor.constraint(equalToConstant: 50),
            buttonStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            buttonStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            buttonStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20)
        
        ])
    }
    */
    
    // MARK: Navigation
    
    func getBackButton() {
       let leftBarButton = navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UI
    func updateUI() {
        detailProductView.configure(for: productResult)
        
    }
    
}

// MARK: - Buttons Configuration
/*
extension DetailProductViewController {
    
     func buyButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Buy now", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.contentHorizontalAlignment = .left
        
        return button
    }
    
    private func cartButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.contentHorizontalAlignment = .right
        
        return button
    }
    
    func setupButtons() {
        let buttonStack = UIStackView()
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.alignment = .bottom
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillProportionally
        buttonStack.backgroundColor = .yellow
        buttonStack.addArrangedSubview(buyButton())
        buttonStack.addArrangedSubview(cartButton())
        
        view.addSubview(buttonStack)
        NSLayoutConstraint.activate([
            buttonStack.widthAnchor.constraint(equalTo: view.widthAnchor),
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            //buttonStack.heightAnchor.constraint(equalToConstant: 100),
            //buttonStack.leftAnchor.constraint(equalTo: view.leftAnchor),
            //buttonStack.rightAnchor.constraint(equalTo: view.rightAnchor),
            
        ])
    }
    
    
}
*/
