//
//  SceneDelegate.swift
//  bex_hw
//
//  Created by Nurpeiis Bexultan on 27.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScene)
//        let nav = UINavigationController(rootViewController: PaymentViewController())
//        window.rootViewController = nav
//        window.makeKeyAndVisible()
//        self.window = window
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = creatTabBar()
        window?.makeKeyAndVisible()
    }

    func creatMenuNC() -> UINavigationController{
           let myMenuVC = MenuViewController()
            myMenuVC.tabBarItem = UITabBarItem(
               title: "Menu",
               image: UIImage(systemName: "house"),
               tag: 0
           )

           return UINavigationController(rootViewController: myMenuVC)
       }

    func creatOrderNC() -> UINavigationController{
           let myOrderVC = OrderViewController()
            myOrderVC.tabBarItem = UITabBarItem(
               title: "Order",
               image: UIImage(systemName: "heart"),
               tag: 1
           )

           return UINavigationController(rootViewController: myOrderVC)
       }

    func creatTabBar() -> UITabBarController{
          let tabbar = UITabBarController()
          UITabBar.appearance().tintColor = .black
          UITabBar.appearance().barTintColor = .systemGray6
          tabbar.viewControllers = [
            creatMenuNC(),
            creatOrderNC()
          ]
          return tabbar
      }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

