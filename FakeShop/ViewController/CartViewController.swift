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
    
        loadSavedData()
        showCount()
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
    
    func populateCountLabel() {
        let fetchRequest = NSFetchRequest<NSNumber>(entityName: "ProductEntity")
        fetchRequest.resultType = .countResultType
        
        do {
            let countResult = try coreDataStack.managedContext.fetch(fetchRequest)
            
            let count = countResult.first?.intValue ?? 0
            cartFooterView.totalAmountOfProducts.text = "\(count)"
        } catch let error as NSError {
            print("count not fetched \(error), \(error.userInfo)")
        }
    }
    func populateTotalPriceLabel() {
        let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ProductEntity")
        fetchRequest.resultType = .dictionaryResultType
        
        let sumExpressionDesc = NSExpressionDescription()
        sumExpressionDesc.name = "price"
        
        let totalPriceExp = NSExpression(forKeyPath: #keyPath(ProductEntity.price))
        sumExpressionDesc.expression = NSExpression(forFunction: "sum:", arguments: [totalPriceExp])
        
        sumExpressionDesc.expressionResultType = .doubleAttributeType
        
        fetchRequest.propertiesToFetch = [sumExpressionDesc]
        
        do {
            
            let results = try coreDataStack.managedContext.fetch(fetchRequest)
            
            let resultDict = results.first
            let totPrice = resultDict?["price"] as? Double ?? 0
            
            cartFooterView.totalSumLabel.text = "\(totPrice)"
        } catch let error as NSError {
            print("price not fetched \(error), \(error.userInfo)")
        }
    }
    
    func showCount() {
        populateCountLabel()
        NotificationCenter.default.addObserver(forName: .NSManagedObjectContextObjectsDidChange, object: coreDataStack.managedContext, queue: .main) { [weak self] _ in
            self?.fetchProducts()
        }
        populateTotalPriceLabel()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func fetchProducts() {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        coreDataStack.managedContext.perform {
            do {
                let results = try fetchRequest.execute()
                self.cartFooterView.totalAmountOfProducts.text = "\(results.count)"
                var total = 0.0
                results.forEach { item in
                    total += item.price
                }
                
                self.cartFooterView.totalSumLabel.text = "\(total)"
                
            } catch {
                print("Unable to Execute Fetch Request, \(error)")
            }
        }
    }
}

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            
           // cartFooterView.totalAmountOfProducts.text = "\(cartResult.products.count)"
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
