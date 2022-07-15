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
       displayCartCount(number: cartResult.products.count)
   }
   func displayCartCount(number: Int) {
       cartFooterView.totalAmountOfProducts.text = "\(number)"
   }
}

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let products = fetchedResultsController?.fetchedObjects else { return 0}
       // return cartResult.products.count
        return products.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.idetifier, for: indexPath) as! CartTableViewCell
        //let listOfProduct = cartResult.products[indexPath.row]
        let product = fetchedResultsController!.object(at: indexPath)
       cell.configureCart(for: product)
        //cell.configureCart(with: CartModelView(with: listOfProduct))
        return cell
    }
  /*  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
       let action = UIContextualAction(style: .destructive, title: "Delete", handler: { [self] (_, _, completionHandler) in
           tableView.deselectRow(at: indexPath, animated: true)
           let product = self.fetchedResultsController?.object(at: indexPath)
           coreDataStack.managedContext.delete(product!)
           coreDataStack.saveData()
           completionHandler(true)
       })
        action.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
   } */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
            let product = self.fetchedResultsController?.object(at: indexPath)
            coreDataStack.managedContext.delete(product!)
            coreDataStack.saveData()
        }
    }
}

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension CartViewController: NSFetchedResultsControllerDelegate {
    
   /* func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    } */
   
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
