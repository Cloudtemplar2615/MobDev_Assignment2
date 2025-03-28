//
//  ViewController.swift
//  Assign2_Tan_Fredrich_101318950
//
//  Created by Fredrich Tan on 2025-03-26.
//

import UIKit
import CoreData

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
   
    var products: [Product] = []
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        fetchProducts()
        
        if products.isEmpty{
            seedProducts()
            fetchProducts()
        }
        displayProduct(at: currentIndex)
    }
    
    func fetchProducts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()

        do {
            products = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }

    func seedProducts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        for i in 1...10 {
            let product = Product(context: context)
            product.id = UUID()
            product.name = "Product \(i)"
            product.productDescription = "Description for product \(i)"
            product.price = Double(i * 10)
            product.provider = "Provider \(i)"
        }

        do {
            try context.save()
        } catch {
            print("Failed to save seeded products: \(error)")
        }
    }

    func displayProduct(at index: Int) {
        guard !products.isEmpty else { return }

        let product = products[index]
        nameLabel.text = "Name: \(product.name ?? "")"
        descriptionLabel.text = "Description: \(product.productDescription ?? "")"
        priceLabel.text = "Price: $\(product.price)"
        providerLabel.text = "Provider: \(product.provider ?? "")"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.isEmpty{
            fetchProducts()
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let request: NSFetchRequest<Product> = Product.fetchRequest()
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@ or productDescription CONTAINS[cd] %@", searchText, searchText)
            
            do{
                products = try context.fetch(request)
                currentIndex = 0
                displayProduct(at: currentIndex)
            }catch{
                print("Search failed: \(error)")
            }
        }
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        if currentIndex < products.count - 1 {
            currentIndex += 1
            displayProduct(at: currentIndex)
        }
    }

    @IBAction func prevTapped(_ sender: UIButton) {
        if currentIndex > 0 {
            currentIndex -= 1
            displayProduct(at: currentIndex)
        }
    }
        
    @IBAction func viewAllTapped(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let listVC = storyboard.instantiateViewController(withIdentifier: "ProductListViewController")
        present(listVC, animated: true)

    }

    @IBAction func addProductTapped(_ sender: UIButton){
        performSegue(withIdentifier: "showAddProduct", sender: self)
    }
}


