//
//  TabBarController.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    lazy var allFriendVC = AllFriendVC()
    lazy var myGroupVC = MyGroupVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        tabBar()
    }
    
    func tabBar() {
        let item1 = UITabBarItem.init(title: "друзья", image: UIImage(systemName: "person.2"), tag: 1)
        let item2 = UITabBarItem.init(title: "сообщества", image: UIImage(systemName: "bubble.left.and.bubble.right"), tag: 1)
        let navigationVCAllFriend = UINavigationController.init(rootViewController: allFriendVC)
        let navigationVCMyGroup = UINavigationController.init(rootViewController: myGroupVC)
        navigationVCAllFriend.tabBarItem = item1
        navigationVCMyGroup.tabBarItem = item2
        viewControllers = [navigationVCAllFriend, navigationVCMyGroup]
    }
}
