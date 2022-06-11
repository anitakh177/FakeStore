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
   
   // private var collectionView = MainViewCollection()
    
  //  private var collectionView2: UICollectionView?
   var network = Network()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
      setupMainStackView()
       
        
      //  setupCollectionView()
    
        network.loadProducts { [weak self] product in
            print("printing in viewDidLoad \(product.first)")
        }
    
        }
    
    // MARK: - Layout
    private func setupProfileHeaderView() {
      mainStackView.addArrangedSubview(mainView)
      mainView.translatesAutoresizingMaskIntoConstraints = false
      mainView.heightAnchor.constraint(equalToConstant: 180).isActive = true
       
    }
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        collectionView.backgroundColor = .blue
        
       /* NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
       */
    }
    
    private func setupMainStackView() {
      mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
      mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.backgroundColor = .yellow
      
      //1
      view.addSubview(mainStackView)
      
      //2
  //    let contentLayoutGuide = view.contentLayoutGuide
      
      NSLayoutConstraint.activate([
        //3
        mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
        //4
        //mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -600)
      ])
      
      setupProfileHeaderView()
      
       

    }
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.scrollDirection = .horizontal
    //  flowLayout.sectionInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        flowLayout.itemSize = CGSize(width: 30, height: 30)
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainViewCollectionViewCell.self, forCellWithReuseIdentifier: MainViewCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = .red
        
        return collectionView
    }()
    
    // MARK: - Layout
   /*
   override func layoutSubviews() {
        super.layoutSubviews()
        let height = collectionView.frame.height - verticalInset * 2
        let width = height
        let itemSize = CGSize(width: width, height: height)
        flowLayout.itemSize = itemSize
    }

*/
    
/*    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } 
/*
     func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blue
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        ])
    }
    */
  */
}


// MARK: - Data Source
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCollectionViewCell.identifier, for: indexPath)
       // cell.contentView.backgroundColor = UIColor.red
        return cell
    }
}
// MARK: - Delegate
extension MainViewController: UICollectionViewDelegate {
    
}
