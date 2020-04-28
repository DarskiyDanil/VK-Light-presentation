//
//  NetworkDataFetch.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 20.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import Foundation

protocol DataFetchProtocol {
    func getFeed(response: @escaping (ResponseNews?) -> Void)
}

struct NetworkDataFetch: DataFetchProtocol {
    
    let networking: NetworkingProtocol
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
    
    func getFeed(response: @escaping (ResponseNews?) -> Void) {
        networking.requestNews { (data, error) in
            if let error = error {
                print("Error getFeed data \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJson(type: NewsFeedModelJsonParsed.self, from: data)
            response(decoded?.response)
        }
    }
    
    
    private func decodeJson<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else {return nil}
        return response
    }
    
    
}