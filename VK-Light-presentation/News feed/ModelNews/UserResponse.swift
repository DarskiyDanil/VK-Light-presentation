//
//  UserResponse.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 28.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import Foundation


// MARK: - UserModelJsonParsed
struct UserModelJsonParsed: Codable {
    let response: [UserResponse]
}

// MARK: - UserResponse
struct UserResponse: Codable {
    let photo100: String?
    
}













