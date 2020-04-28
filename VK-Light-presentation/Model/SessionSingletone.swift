//
//  SessionSingletone.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import Foundation

class SessionSingletone {
    
    static let shared = SessionSingletone()
    private init(){}
    
    var token = ""
    var userId = Int()
    var ownerIdSelectedPerson = ""
    let apiVersion = "5.103"
    let developerСlientId = "6646537"
    
    let scheme = "https"
    let host = "api.vk.com"
    
}
