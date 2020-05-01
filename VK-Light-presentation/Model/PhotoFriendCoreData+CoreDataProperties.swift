//
//  PhotoFriendCoreData+CoreDataProperties.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 01.05.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//
//

import Foundation
import CoreData


extension PhotoFriendCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoFriendCoreData> {
        return NSFetchRequest<PhotoFriendCoreData>(entityName: "PhotoFriendCoreData")
    }

    @NSManaged public var id: Int64
    @NSManaged public var ownerId: Int64
    @NSManaged public var urlPhotoCoreData: NSOrderedSet?

}

// MARK: Generated accessors for urlPhotoCoreData
extension PhotoFriendCoreData {

    @objc(insertObject:inUrlPhotoCoreDataAtIndex:)
    @NSManaged public func insertIntoUrlPhotoCoreData(_ value: UrlPhotoCoreData, at idx: Int)

    @objc(removeObjectFromUrlPhotoCoreDataAtIndex:)
    @NSManaged public func removeFromUrlPhotoCoreData(at idx: Int)

    @objc(insertUrlPhotoCoreData:atIndexes:)
    @NSManaged public func insertIntoUrlPhotoCoreData(_ values: [UrlPhotoCoreData], at indexes: NSIndexSet)

    @objc(removeUrlPhotoCoreDataAtIndexes:)
    @NSManaged public func removeFromUrlPhotoCoreData(at indexes: NSIndexSet)

    @objc(replaceObjectInUrlPhotoCoreDataAtIndex:withObject:)
    @NSManaged public func replaceUrlPhotoCoreData(at idx: Int, with value: UrlPhotoCoreData)

    @objc(replaceUrlPhotoCoreDataAtIndexes:withUrlPhotoCoreData:)
    @NSManaged public func replaceUrlPhotoCoreData(at indexes: NSIndexSet, with values: [UrlPhotoCoreData])

    @objc(addUrlPhotoCoreDataObject:)
    @NSManaged public func addToUrlPhotoCoreData(_ value: UrlPhotoCoreData)

    @objc(removeUrlPhotoCoreDataObject:)
    @NSManaged public func removeFromUrlPhotoCoreData(_ value: UrlPhotoCoreData)

    @objc(addUrlPhotoCoreData:)
    @NSManaged public func addToUrlPhotoCoreData(_ values: NSOrderedSet)

    @objc(removeUrlPhotoCoreData:)
    @NSManaged public func removeFromUrlPhotoCoreData(_ values: NSOrderedSet)

}
