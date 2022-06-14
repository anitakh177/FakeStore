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
 
var networkManager = NetworkManager()
    var productResults = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
      setupMainStackView()
        setupCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        
       
        networkManager.loadProducts()
        networkManager.delegate = self
        collectionView.reloadData()
       
        
    }
 /*
    func loadProductData() {
        
        network.getProducts { (result) in
        
            switch result {
                
            case .success(let listOf):
            
        
            case .failure(let error):
                self.showAlertWith(title: "Could Not Connect!", message: "Please check your internet connetcion \n or try again later")
                print("Error processing JSON data: \(error)")
            }
        }
        
    } */
    // MARK: - Alert message
    
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Layout
    private func setupProfileHeaderView() {
      mainStackView.addArrangedSubview(mainView)
      mainView.translatesAutoresizingMaskIntoConstraints = false
      mainView.heightAnchor.constraint(equalToConstant: 180).isActive = true
       
    }
 /*   private func setupCollectionView() {
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
    */
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
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        //4
        //mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -600)
      ])
      
      setupProfileHeaderView()
      
       

    }
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 15
        flowLayout.scrollDirection = .horizontal
    //  flowLayout.sectionInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.itemSize = CGSize(width: 150, height: 220)
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
*/
     func setupCollectionView() {
         view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blue
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        
        ])
    }
    
  
}


// MARK: - Data Source
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCollectionViewCell.identifier, for: indexPath) as! MainViewCollectionViewCell
        let listOfProduct = productResults[indexPath.row]
        cell.configure(for: listOfProduct)
            return cell
       
    }
}
// MARK: - Delegate
extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: NetworkManagerDelegate {
    func didSendProductData(_ productService: NetworkManager, with product: [Product]) {
        self.productResults.append(contentsOf: product)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            print(self.productResults.count)
        }
    }
    
}
