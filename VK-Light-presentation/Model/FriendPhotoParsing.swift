//
//  FriendPhotoParsing.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import Foundation

struct  FriendsPhotoJSONResponse: Decodable {
    let response: FriendsPhotoJSONItems
}

struct  FriendsPhotoJSONItems: Decodable {
    let items: [PhotoFriendParsedData]
}

struct PhotoFriendParsedData: Decodable {
    var id: Int
    var ownerId: Int
    var sizes: [UrlPhotoItems]
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case sizes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        ownerId = try container.decode(Int.self, forKey: .ownerId)
        sizes = try container.decode([UrlPhotoItems].self, forKey: .sizes)
    }
}

struct  UrlPhotoItems: Decodable {
    var type: String
    var url: String
    var width: Int
    var height: Int
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
        case width
        case height
    }

}

extension PhotoFriendParsedData {
    init(data: Data) throws {
        self = try JSONDecoder().decode(PhotoFriendParsedData.self, from: data)
    }
}
