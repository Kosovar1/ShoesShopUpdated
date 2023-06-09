//
//  ToDoListItem+CoreDataProperties.swift
//  
//
//  Created by Kosovar Latifi on 02/05/2023.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var id: Int16
    @NSManaged public var attribute3: String?
    @NSManaged public var price: Double
    @NSManaged public var title: String?
    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?

}
