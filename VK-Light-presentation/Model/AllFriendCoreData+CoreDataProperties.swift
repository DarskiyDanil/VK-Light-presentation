//
//  AllFriendCoreData+CoreDataProperties.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 01.05.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//
//

import Foundation
import CoreData


extension AllFriendCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AllFriendCoreData> {
        return NSFetchRequest<AllFriendCoreData>(entityName: "AllFriendCoreData")
    }

    @NSManaged public var dateDownload: Date?
    @NSManaged public var firstName: String?
    @NSManaged public var id: Int64
    @NSManaged public var imageUrl: String?
    @NSManaged public var lastName: String?

}
