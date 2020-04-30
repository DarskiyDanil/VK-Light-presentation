//
//  NetworkDataFetch.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 20.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import Foundation

protocol DataFetchProtocol {
    func getFeed(nextNewsListFrom: String?, response: @escaping (ResponseNews?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetch: DataFetchProtocol {
    
    let networking: NetworkingProtocol
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
    
    func getFeed(nextNewsListFrom: String?, response: @escaping (ResponseNews?) -> Void) {
        networking.requestNews(queryValue: nextNewsListFrom) { (data, error) in
            if let error = error {
                print("Error getFeed data \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJson(type: NewsFeedModelJsonParsed.self, from: data)
            response(decoded?.response)
        }
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
     networking.requestUsers { (data, error) in
            if let error = error {
                print("Error getFeed data \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJson(type: UserModelJsonParsed.self, from: data)
        response(decoded?.response.first)
        }
    }
    
    private func decodeJson<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else {return nil}
        return response
    }
    
    
}
