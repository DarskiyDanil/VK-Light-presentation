//
//  LogInVC.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//
import Foundation
import WebKit

class LogInVC: UIViewController, UIWebViewDelegate {
    
    lazy var tabBarPresentController = TabBarController()
    fileprivate let wKWebView: WKWebView = {
        let wKWebView = WKWebView()
        wKWebView.translatesAutoresizingMaskIntoConstraints = false
        return wKWebView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wKWebView.navigationDelegate = self
        self.view.addSubview(wKWebView)
        wKWebView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        wKWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        wKWebView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        wKWebView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        requestLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //      возвращаем верхнюю панель
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    fileprivate func requestLogin() {
        var urlComponents = URLComponents()
        urlComponents.scheme = SessionSingletone.shared.scheme
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: SessionSingletone.shared.developerСlientId),
            URLQueryItem(name: "redirect_url", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: SessionSingletone.shared.apiVersion)
        ]
        let request = URLRequest(url: urlComponents.url!)
        DispatchQueue.main.async{
            self.wKWebView.load(request)
        }
    }
}

extension LogInVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let parameters = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, parameters in
                var dictionary = result
                let key = parameters[0]
                let value = parameters[1]
                dictionary[key] = value
                return dictionary
        }
        
        guard let tokenAccess = parameters["access_token"],
            let userID = Int(parameters["user_id"]!) else {
                decisionHandler(.cancel)
                return
        }
        
        SessionSingletone.shared.token = tokenAccess
        SessionSingletone.shared.userId = userID
        
        self.present(self.tabBarPresentController, animated: true, completion: nil)
        decisionHandler(.cancel)
    }
    
}
