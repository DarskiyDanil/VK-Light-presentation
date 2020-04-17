//
//  UrlPhotoCoreData+CoreDataProperties.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 05.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//
//

import Foundation
import CoreData


extension UrlPhotoCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UrlPhotoCoreData> {
        return NSFetchRequest<UrlPhotoCoreData>(entityName: "UrlPhotoCoreData")
    }

    @NSManaged public var height: Int64
    @NSManaged public var url: String?
    @NSManaged public var width: Int64
    @NSManaged public var photoFriendCoreData: PhotoFriendCoreData?

}
