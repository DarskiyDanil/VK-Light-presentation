//
//  AllGroupCoreData+CoreDataProperties.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 01.05.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//
//

import Foundation
import CoreData


extension AllGroupCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AllGroupCoreData> {
        return NSFetchRequest<AllGroupCoreData>(entityName: "AllGroupCoreData")
    }

    @NSManaged public var dateDownload: Date?
    @NSManaged public var id: Int64
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?

}
