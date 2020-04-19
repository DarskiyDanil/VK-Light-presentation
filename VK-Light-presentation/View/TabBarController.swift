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
    
    fileprivate let allFriendItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "друзья"
        item.image = UIImage(systemName: "person.2")
        return item
    }()
    
    fileprivate let groupItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "сообщества"
        item.image = UIImage(systemName: "person.3")
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.tabBar()
        }
    }
    
    fileprivate func tabBar() {
        
        navigationVCAllFriend.tabBarItem = allFriendItem
        navigationVCMyGroup.tabBarItem = groupItem
        viewControllers = [navigationVCAllFriend, navigationVCMyGroup]
    }
}
