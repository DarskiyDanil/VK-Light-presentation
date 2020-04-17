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
    var IdUser = Int()
    var idFRIEND = ""
    let apiVersion = "5.95"
    let userDeveloperId = "6646537"
    let baseUrl = "https://api.vk.com"
    
}
