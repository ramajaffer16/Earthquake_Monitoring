//
//  SceneDelegate.swift
//  Earthquake Monitoring
//
//  Created by Gracie on 24/06/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {return}
        let window = UIWindow(windowScene: windowScene)
        
        // creating view controllers variables through the controller instances
        let homeViewController = HomeController()
        let earthquakeViewController = EarthquakeViewController(viewModel: EarthquakeViewModel()) // added parameter coz it takes viewmodel data

        // creating navigation controller
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)// the rootview controller is the controller moving from
        homeNavigationController.title = "Welcome"
        
        let earthquakeNavigationController = UINavigationController(rootViewController: earthquakeViewController)
        earthquakeNavigationController.title = "Earthquake Data"
        
       //I can also create tab-bar controller here using UITabBarController() but since I have a tabbar controller file I wont and instead customize there
    
        window.rootViewController = TabbarController()
        self.window = window
        self.window?.makeKeyAndVisible()
    }


}
