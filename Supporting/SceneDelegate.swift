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
        
        let nav = UINavigationController()
        nav.setViewControllers([homeViewController], animated:true)
        nav.pushViewController(earthquakeViewController, animated:true)

    
    
        window.rootViewController = TabbarController()
        self.window = window
        self.window?.makeKeyAndVisible()
    }


}
