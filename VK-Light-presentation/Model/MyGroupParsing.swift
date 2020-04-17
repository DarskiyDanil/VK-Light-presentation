//
//  MyGroupParsing.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import Foundation

struct  AllGroupResponse: Decodable {
    let response: Items
}

struct  Items: Decodable {
    let items: [AllGroupParsedData]
}

struct AllGroupParsedData: Decodable {
    
    var id: Int
    var name: String
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "photo_50"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
    }
    
}
