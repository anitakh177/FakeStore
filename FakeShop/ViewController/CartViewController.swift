//
//  CartViewController.swift
//  FakeShop
//
//  Created by anita on 01.07.2022.
//

import UIKit
import CoreData

class CartViewController: UIViewController {
    var downloadTask: URLSessionDownloadTask?
   
    lazy var coreDataStack = CoreDataStack(modelName: "ProductEntity")
    var cartResult = CartManager()
    var fetchedResultsController: NSFetchedResultsController<ProductEntity>?
    
    
    private var cartFooterView = CartFooterView()
    private var cartCell = CartTableViewCell()
    
   
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.idetifier)
        table.rowHeight = 140
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.reloadData()
        getBack()
        setupFooterView()
        showTotal()
        loadSavedData()
    }

   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-100))
    }
    
    private func loadSavedData() {
        if fetchedResultsController == nil {
            let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
            let sort = NSSortDescriptor(key: "name", ascending: false)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController!.delegate = self
        }
        do {
            try fetchedResultsController!.performFetch()
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
    
    
    @objc func changeValueStepper(_ sender:UIStepper!) {
        displayTotal(number: cartResult.total)
        displayCartCount(number: cartResult.products.count)
        print("UIStepper is now \(Int(sender.value))")
        
    }
    private func setupFooterView() {
        view.addSubview(cartFooterView)
        cartFooterView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cartFooterView.heightAnchor.constraint(equalToConstant: 100),
            cartFooterView.widthAnchor.constraint(equalTo: view.widthAnchor),
            cartFooterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cartFooterView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
   
    func getBack() {
        _ = navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}

extension CartViewController: CartViewManagerDelegate, CartManagerShowTotalDelegate  {
    func displayTotal(number: Double) {
       cartFooterView.totalSumLabel.text = "\(number)$"
   }

   private func showTotal() {
       displayTotal(number: cartResult.total)
       //displayCartCount(number: cartResult.products.count)
       do {
           let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
           let numberOfProducts = try coreDataStack.managedContext.count(for: request)
           displayCartCount(number: numberOfProducts)
       } catch {
           print("error to show number of products")
       }
      
   }
   func displayCartCount(number: Int) {
       cartFooterView.totalAmountOfProducts.text = "\(number)"
   }
}

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         //return cartResult.products.count
        let sectionInfo = fetchedResultsController?.sections![section]
        return sectionInfo?.numberOfObjects ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.idetifier, for: indexPath) as! CartTableViewCell
        //let listOfProduct = cartResult.products[indexPath.row]
        let product = fetchedResultsController!.object(at: indexPath)
       cell.configureCart(for: product)
        //cell.configureCart(with: CartModelView(with: listOfProduct))
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
    
            let product = self.fetchedResultsController?.object(at: indexPath)
            coreDataStack.managedContext.delete(product!)
            coreDataStack.saveData()
            //tableView.deleteRows(at: [indexPath], with: .fade)
           
        }
    }
}

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension CartViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.reloadData()
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
   
}
