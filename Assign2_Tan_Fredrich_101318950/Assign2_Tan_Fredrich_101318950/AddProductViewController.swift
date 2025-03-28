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
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var providerField: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func showAlert(message: String) {
            let alert = UIAlertController(title: "Invalid Input",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        }
    
    @IBAction func saveTapped(_ sender: UIButton){
        
            guard
                    let nameText = nameField.text, !nameText.isEmpty,
                    let descText = descriptionTextField.text, !descText.isEmpty
                else {
                    showAlert(message: "Name and description cannot be empty.")
                    return
                }
       

        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let product = Product(context: context)
        product.id = UUID()
        product.name = nameText
        product.productDescription = descText
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
