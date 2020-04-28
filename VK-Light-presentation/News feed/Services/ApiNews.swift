//
//  ApiNews.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 20.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import Foundation

protocol NetworkingProtocol {
    func requestNews(completion: @escaping (Data?, Error?) -> Void)
    func requestUsers(completion: @escaping (Data?, Error?) -> Void)
}

class ApiNews: NetworkingProtocol {
    
    // MARK: - Request News List
    func requestNews(completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            var urlComponents = URLComponents()
            urlComponents.scheme = SessionSingletone.shared.scheme
            urlComponents.host = SessionSingletone.shared.host
            urlComponents.path = "/method/newsfeed.get"
            urlComponents.queryItems = [
                URLQueryItem(name: "access_token", value: SessionSingletone.shared.token),
                URLQueryItem(name: "filters", value: "post, photo"),
                //                URLQueryItem(name: "count", value: "5"),
                URLQueryItem(name: "v", value: SessionSingletone.shared.apiVersion)
            ]
            guard let url = urlComponents.url else {return}
            let task = self.coreDataTask(from: url, completion: completion)
            task.resume()
        }
    }
    
    // MARK: - Request User
    func requestUsers(completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            var urlComponents = URLComponents()
            urlComponents.scheme = SessionSingletone.shared.scheme
            urlComponents.host = SessionSingletone.shared.host
            urlComponents.path = "/method/users.get"
            urlComponents.queryItems = [
                URLQueryItem(name: "access_token", value: SessionSingletone.shared.token),
                URLQueryItem(name: "fields", value: "photo_100"),
                URLQueryItem(name: "user_ids", value: String(SessionSingletone.shared.userId)),
                URLQueryItem(name: "v", value: SessionSingletone.shared.apiVersion)
            ]
            guard let url = urlComponents.url else {return}
            let task = self.coreDataTask(from: url, completion: completion)
            task.resume()
        }
    }
    
    private func coreDataTask (from url: URL, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: url) {(data, response, error) in
            DispatchQueue.main.async{
                completion(data, error)
            }
        }
    }
    
}
