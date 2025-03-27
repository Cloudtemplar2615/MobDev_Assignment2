//
//  AddProductViewController.swift
//  Assign2_Tan_Fredrich_101318950
//
//  Created by Fredrich Tan on 2025-03-26.
//

import UIKit
import CoreData

class AddProductViewController: UIViewController{
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var providerField: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveTapped(_ sender: UIButton){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let product = Product(context: context)
        product.id = UUID()
        product.name = nameField.text
        product.productDescription = descField.text
        product.provider  = providerField.text
        product.price = Double(priceField.text ?? "0") ?? 0.0
        
        do{
            try context.save()
            self.dismiss(animated: true)
        }catch{
            print("Failed to save new product: \(error)")
        }
    }

}
