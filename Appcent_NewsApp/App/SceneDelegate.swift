//
//  SceneDelegate.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().tintColor = .systemBlue
    }

    private func createNewsNC() -> UINavigationController {
        let newsScreen = NewsScreen()
        newsScreen.title = "Appcent NewsApp"
        newsScreen.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)
        
        return UINavigationController(rootViewController: newsScreen)
    }
    
    private func createFavoritesNC() -> UINavigationController {
        let favoritesScreen = FavoritesScreen()
        favoritesScreen.title = "Favorites"
        favoritesScreen.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart"), tag: 1)
        
        return UINavigationController(rootViewController: favoritesScreen)
    }
    
    private func createTabbar() -> UITabBarController {
        let tabbar                      = UITabBarController()
        UITabBar.appearance().tintColor = .systemBlue
        tabbar.viewControllers          = [createNewsNC(), createFavoritesNC()]
        
        return tabbar
    }
}

