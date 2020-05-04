//
//  TabBarController.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.tabBar()
        }
    }
    
    fileprivate func tabBar() {
        viewControllers = [tabBarVC(rootVC: NewsFeedViewController(), image: UIImage(systemName: "rectangle.dock")!, title: "лента"),
                           tabBarVC(rootVC: AllFriendVC(), image: UIImage(systemName: "person.2")!, title: "друзья"),
                           tabBarVC(rootVC: MyGroupVC(), image: UIImage(systemName: "person.3")!, title: "сообщества")]
    }
    
    func tabBarVC(rootVC: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        return navigationVC
    }
    
    
}
