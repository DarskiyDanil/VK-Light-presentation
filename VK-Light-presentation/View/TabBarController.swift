//
//  TabBarController.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    fileprivate let navigationVCAllFriend = UINavigationController(rootViewController: AllFriendVC())
    fileprivate let navigationVCMyGroup = UINavigationController(rootViewController: MyGroupVC())
    fileprivate let navigationVCNews = UINavigationController(rootViewController: NewsFeedViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.tabBar()
        }
    }
    
    fileprivate func tabBar() {
        
        navigationVCAllFriend.tabBarItem.image = UIImage(systemName: "person.2")
        navigationVCAllFriend.tabBarItem.title = "друзья"
        navigationVCMyGroup.tabBarItem.image = UIImage(systemName: "person.3")
        navigationVCMyGroup.tabBarItem.title = "сообщества"
        navigationVCNews.tabBarItem.image = UIImage(systemName: "rectangle.dock")
        navigationVCNews.tabBarItem.title = "лента"
        
        viewControllers = [navigationVCNews, navigationVCAllFriend, navigationVCMyGroup]
    }
}
