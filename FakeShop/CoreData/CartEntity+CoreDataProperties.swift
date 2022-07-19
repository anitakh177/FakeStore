//
//  CartEntity+CoreDataProperties.swift
//  FakeShop
//
//  Created by anita on 19.07.2022.
//
//

import Foundation
import CoreData


extension CartEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartEntity> {
        return NSFetchRequest<CartEntity>(entityName: "CartEntity")
    }

    @NSManaged public var total: Double
    @NSManaged public var date: Date?
    @NSManaged public var product: ProductEntity?

}

extension CartEntity : Identifiable {

}
