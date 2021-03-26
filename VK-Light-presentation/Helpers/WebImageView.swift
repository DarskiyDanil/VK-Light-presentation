//
//  WebImageView.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 22.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

// кеширование

class WebImageView: UIImageView {
    
    private var currentUrlString: String?
    
    func set(imageUrl: String?) {
        currentUrlString = imageUrl
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
            //                от мерцаний при прокрутке
            self.image = nil
            return}
        //        проверка на наличие в кеш
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, let response = response else {return}
            DispatchQueue.main.async {
                self?.cacheLoadedImage(data: data, response: response)
            }
        }
        dataTask.resume()

    }
    
    //    кеширование
    private func cacheLoadedImage(data: Data, response: URLResponse) {
        guard let responseUrl = response.url else {return}
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl))
        if responseUrl.absoluteString == currentUrlString {
            self.image = UIImage(data: data)
        }
    }
    
}
