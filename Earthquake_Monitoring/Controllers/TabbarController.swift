//
//  TabbarController.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 26/06/2024.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
        // change the background of the tabbar
//        self.tabBar.barTintColor = UIColor.red
        
        // change the icon and the title color
        self.tabBar.tintColor = UIColor.green
        
        
        self.tabBar.unselectedItemTintColor = UIColor.purple

        
    }
    
    private func setupTabs(){
        let homeController = HomeController()
        let earthquakeViewController = EarthquakeViewController()
            
        let home = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: homeController)
        let history = self.createNav(with: "History", and: UIImage(systemName: "clock"), vc: earthquakeViewController)
        
        
        self.setViewControllers([], animated: true)
    }
    
    private func createNav(with title:String, and image: UIImage?,vc: UIViewController)-> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title + "Controller"
    }
   

}
