//
//  ProductListViewController.swift
//  Assign2_Tan_Fredrich_101318950
//
//  Created by Fredrich Tan on 2025-03-27.
//

import UIKit
import CoreData

class ProductListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchProducts()
    }
    
    @IBAction func sortSegmentChanged(_ sender: UISegmentedControl){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        if sender.selectedSegmentIndex == 0{
            let sort = NSSortDescriptor(key: "price", ascending: true)
            request.sortDescriptors = [sort]
        }else{
            let sort = NSSortDescriptor(key: "price", ascending: false)
            request.sortDescriptors = [sort]
        }
        do{
            products = try context.fetch(request)
            tableView.reloadData()
        }catch{
            print("Failed to fetch products \(error)")
        }
    }
    
    func fetchProducts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        let sort = NSSortDescriptor(key: "price", ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            products = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
            let product = products[indexPath.row]
            
            let name = product.name ?? "Unknown"
            let price = product.price
            let provider = product.provider ?? "Unknown"
            
            cell.textLabel?.text = "\(name) - $\(price) by \(provider)"
            
            return cell
        }
    

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let productToDelete = products[indexPath.row]

            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(productToDelete)

            do {
                try context.save()
                products.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Error deleting product: \(error)")
            }
        }
    }
}
