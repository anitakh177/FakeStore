//
//  ViewController.swift
//  FakeShop
//
//  Created by anita on 06.06.2022.
//

import UIKit

class MainViewController: UIViewController {
    
   private var mainView = MainView()
    private var mainStackView = UIStackView()
   private var scrollView = UIScrollView()
    
   var network = Network()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupMainStackView()
        network.loadProducts()
        
        
}
    
   
    
    // MARK: - Layout
    
    private func setupScrollView() {
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(scrollView)
      
      let frameLayoutGuide = scrollView.frameLayoutGuide
      
      NSLayoutConstraint.activate([
        frameLayoutGuide.leadingAnchor.constraint(equalTo:
          view.leadingAnchor),
        frameLayoutGuide.trailingAnchor.constraint(equalTo:
          view.trailingAnchor),
       frameLayoutGuide.topAnchor.constraint(equalTo:
          view.safeAreaLayoutGuide.topAnchor),
        frameLayoutGuide.bottomAnchor.constraint(equalTo:
          view.safeAreaLayoutGuide.bottomAnchor)
      ])
    }
    private func setupProfileHeaderView() {
      mainStackView.addArrangedSubview(mainView)
      mainView.translatesAutoresizingMaskIntoConstraints = false
      mainView.heightAnchor.constraint(equalToConstant: 180).isActive = true
       
    }
    
    private func setupMainStackView() {
      mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
      mainStackView.translatesAutoresizingMaskIntoConstraints = false
      
      //1
      scrollView.addSubview(mainStackView)
      
      //2
      let contentLayoutGuide = scrollView.contentLayoutGuide
      
      NSLayoutConstraint.activate([
        //3
        mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        mainStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
        mainStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
        mainStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
        //4
        mainStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
      ])
      
      setupProfileHeaderView()
       
      
    }
}
