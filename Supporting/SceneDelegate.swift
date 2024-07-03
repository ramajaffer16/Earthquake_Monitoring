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
//        let apiService = APIServiceImpl() 
//                let viewModel = EarthquakeViewModel(apiService: apiService)
//                let viewController = EarthquakeViewController(viewModel: viewModel)
        let window = UIWindow(windowScene: windowScene)
        let homeViewController = HomeController()  
        let earthquakeViewController = EarthquakeViewController(viewModel: EarthquakeViewModel())

                let homeNavigationController = UINavigationController(rootViewController: homeViewController)
                let earthquakeNavigationController = UINavigationController(rootViewController: earthquakeViewController)

        window.rootViewController = TabbarController()
        self.window = window
        self.window?.makeKeyAndVisible()
    }


}
