//
//  ProductEntity+CoreDataProperties.swift
//  FakeShop
//
//  Created by anita on 19.07.2022.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var productDescription: String?
    @NSManaged public var productID: Int16
    @NSManaged public var cart: NSArray?

}

// MARK: Generated accessors for cart
extension ProductEntity {

    @objc(addCartObject:)
    @NSManaged public func addToCart(_ value: CartEntity)

    @objc(removeCartObject:)
    @NSManaged public func removeFromCart(_ value: CartEntity)

    @objc(addCart:)
    @NSManaged public func addToCart(_ values: NSArray)

    @objc(removeCart:)
    @NSManaged public func removeFromCart(_ values: NSArray)

}

extension ProductEntity : Identifiable {

}
