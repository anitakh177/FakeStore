//
//  ProductEntity+CoreDataProperties.swift
//  FakeShop
//
//  Created by anita on 14.07.2022.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var name: String
    @NSManaged public var price: Double
    @NSManaged public var productDescription: String
    @NSManaged public var image: String?
    @NSManaged public var productID: Int16

}

extension ProductEntity : Identifiable {

}
