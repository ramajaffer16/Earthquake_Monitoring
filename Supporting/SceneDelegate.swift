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
        let HomeController = UIViewController()
        let firstNavController = UINavigationController(rootViewController: HomeController)
        
        let EarthquakeViewController = UIViewController()
        let secondNavController = UINavigationController(rootViewController: EarthquakeViewController)
        window.rootViewController = TabbarController()
        self.window = window
        self.window?.makeKeyAndVisible()
    }


}
