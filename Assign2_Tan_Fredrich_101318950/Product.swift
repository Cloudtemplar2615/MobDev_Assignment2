//
//  Product.swift
//  Assign2_Tan_Fredrich_101318950
//
//  Created by Fredrich Tan on 2025-03-26.
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject {
    
    @nonobjc public class  func fetchRequest() -> NSFetchRequest<Product> {
         return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var price: Double
    @NSManaged public var provider: String?
}


