//
//  NewsFeedModelJsonParsed.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 20.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import Foundation

// MARK: - NewsFeedModelJsonParsed
struct NewsFeedModelJsonParsed: Codable {
    let response: ResponseNews
}

// MARK: - Response
struct ResponseNews: Codable {
    var items: [ItemNewsFeed]
    var profiles: [ProfileNewsFeed]
    var groups: [GroupNewsFeed]
    var nextFrom: String?
}

// MARK: - ItemNewsFeed
struct ItemNewsFeed: Codable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: Comments?
    let likes: Comments?
    let reposts: Comments?
    let views: Comments?
    var attachments: [AttachmentItem]?
}

// MARK: Comments
struct Comments: Codable {
    let count: Int
}

protocol ProfilePresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

// MARK: - ProfileNewsFeed
struct ProfileNewsFeed: Codable, ProfilePresentable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    var name: String { return firstName + "  " + lastName }
    var photo: String { photo100 }
}

// MARK: - GroupNewsFeed
struct GroupNewsFeed: Codable, ProfilePresentable {
    let id: Int
    let name: String
    let photo100: String
    var photo: String { return photo100 }
}

// MARK: - AttachmentItem
struct AttachmentItem: Codable {
    let photo: PhotoAttachment?
}

// MARK: - PhotoAttachment
struct PhotoAttachment: Codable {
    //    let id: Int
    var sizes: [PhotoSizes]
    var width: Int {
        return getPropperSize().width
    }
    var height: Int {
        return getPropperSize().height
    }
    var srcBig: String {
        return getPropperSize().url
    }
    
    private func getPropperSize() -> PhotoSizes {
        if let sizeX = sizes.first(where: {$0.type == "x"}) {
            return sizeX
        } else {
            return PhotoSizes(type: "нет картинки", url: "нет картинки", width: 0, height: 0)
        }
    }
}

// MARK: - PhotoSizes
struct PhotoSizes: Codable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
