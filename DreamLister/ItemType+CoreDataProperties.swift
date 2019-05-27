//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Luis Santos on 5/24/19.
//  Copyright © 2019 Luis Santos. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
