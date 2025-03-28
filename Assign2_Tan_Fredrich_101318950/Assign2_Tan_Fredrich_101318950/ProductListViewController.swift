//
//  ProductListViewController.swift
//  Assign2_Tan_Fredrich_101318950
//
//  Created by Fredrich Tan on 2025-03-27.
//

import UIKit
import CoreData

class ProductListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchProducts()
    }
    
    func fetchProducts(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        do{
            products = try context.fetch(request)
            tableView.reloadData()
        }catch{
            print("Failed to fetch products: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        return cell
    }

}
