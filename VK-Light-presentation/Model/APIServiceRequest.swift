//
//  APIServiceRequest.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import Foundation

// передача данных через делегат
protocol APIServiceRequestDelegate: class {
    func updateMyGroupsInterface(_: APIServiceRequest, with parsedData: (data: [AllGroupParsedData], error: Error?))
}

class APIServiceRequest {
    weak var delegate: APIServiceRequestDelegate?
    
    // MARK: - Request All Friends List
    func requestAllFriends(completion: @escaping ([AllFriendParsedData]?, Error?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/friends.get"
            urlComponents.queryItems = [
                URLQueryItem(name: "user_id", value: String(SessionSingletone.shared.IdUser)),
                URLQueryItem(name: "access_token", value: SessionSingletone.shared.token),
                URLQueryItem(name: "count", value: "5000"),
                URLQueryItem(name: "order", value: "hints"),
                URLQueryItem(name: "fields", value: "nickname, photo_100"),
                URLQueryItem(name: "v", value: SessionSingletone.shared.apiVersion)
            ]
            guard let url = urlComponents.url else {return}
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                
                guard let currentData = data else { return }
                // парсинг JSON
                do {
                    let allFriendParsedData = try JSONDecoder().decode(FriendsJSONResponse.self, from: currentData)
                    DispatchQueue.main.async{
                        completion(allFriendParsedData.response.items, error)
                    }
                } catch let error as Error? {
                    print("requestAllFriends error: \(String(describing: error?.localizedDescription))")
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Request Photos to One Friend
    
    func requestPhotosOneFriend(ownerId: String, completion: @escaping ([PhotoFriendParsedData]?, Error?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/photos.get"
            urlComponents.queryItems = [
                URLQueryItem(name: "owner_id", value: ownerId),
                URLQueryItem(name: "access_token", value: SessionSingletone.shared.token),
                URLQueryItem(name:"album_id", value: "profile"),
                URLQueryItem(name: "rev", value: "0"),
                URLQueryItem(name: "count", value: "100"),
                URLQueryItem(name: "v", value: SessionSingletone.shared.apiVersion)
            ]
            
            guard let url = urlComponents.url else {return}
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let currentData = data else { return }
                // парсинг JSON
                do {
                    let allGroupParsedData = try JSONDecoder().decode(FriendsPhotoJSONResponse.self, from: currentData)
                    //                    print(allGroupParsedData)
                    DispatchQueue.main.async{
                        completion(allGroupParsedData.response.items, error)
                    }
                } catch let error as Error? {
                    print("requestPhotosOneFriend error: \(String(describing: error?.localizedDescription))")
                }
            }
            task.resume()
        }
    }
    
    // MARK: - request all groups list and send of Delegate
    func requestAllGroups() {
        DispatchQueue.global(qos: .userInitiated).async {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/groups.get"
            urlComponents.queryItems = [
                URLQueryItem(name: "user_id", value: String(SessionSingletone.shared.IdUser)),
                URLQueryItem(name: "access_token", value: SessionSingletone.shared.token),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "v", value: SessionSingletone.shared.apiVersion)
            ]
            
            guard let url = urlComponents.url else {return}
            self.requestingAndTransmittingAllFriendsData(url: url)
        }
    }
    
    fileprivate func requestingAndTransmittingAllFriendsData(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let currentData = data else { return }
            // парсинг JSON
            do {
                let allGroupParsedData = try JSONDecoder().decode(AllGroupResponse.self, from: currentData)
                // передача данных через делегат
                DispatchQueue.main.async{
                    self.delegate?.updateMyGroupsInterface(self, with: (data: allGroupParsedData.response.items, error: error))
                }
            } catch let error as Error? {
                print("requestAllGroups error: \(String(describing: error?.localizedDescription))")
            }
        }
        task.resume()
    }
    
    
}
