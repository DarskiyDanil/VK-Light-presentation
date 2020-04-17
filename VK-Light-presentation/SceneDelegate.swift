//
//  SceneDelegate.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let contentView = LogInVC()
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = contentView
        window?.makeKeyAndVisible()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Вызывается, когда сцена освобождается системой.
        // Это происходит вскоре после того, как сцена входит в фон или когда ее сеанс отбрасывается.
        // Освобождаем любые ресурсы, связанные с этой сценой, которые могут быть воссозданы при следующем подключении сцены.
        // Сцена может повторно подключиться позже, поскольку ее сеанс не был обязательно удален (см. Вместо этого `application: didDiscardSceneSessions`)
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Вызывается, когда сцена перешла из неактивного состояния в активное состояние.
        // Используйте этот метод для перезапуска любых задач, которые были приостановлены (или еще не запущены), когда сцена была неактивной.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Вызывается, когда сцена переходит из активного состояния в неактивное состояние.
        // Это может произойти из-за временных прерываний (например, входящий телефонный звонок).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Вызывается при переходе сцены из фона на передний план.
        // Используйте этот метод, чтобы отменить изменения, внесенные при входе в фон.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Вызывается при переходе сцены с переднего на задний план.
        // Используйте этот метод для сохранения данных, освобождения общих ресурсов и хранения достаточного количества информации о состоянии сцены
        // чтобы восстановить сцену до ее текущего состояния.
        // Сохраняем изменения в контексте управляемого объекта приложения, когда приложение переходит в фоновый режим.
        (UIApplication.shared.delegate as? AppDelegate)?.coreDataManager.saveContext()
    }
    
    
}

