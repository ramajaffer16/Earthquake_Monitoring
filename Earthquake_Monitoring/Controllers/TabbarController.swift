//
//  TabbarController.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 26/06/2024.
//

import UIKit

class TabbarController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    private func setupTabs(){
        let homeController = HomeController()
        let earthquakeViewController = EarthquakeViewController()
            
        let home = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: homeController)
        let home = self.createNav(with: "History", and: UIImage(systemName: "clock"), vc: earthquakeViewController)
        
        
        self.setViewControllers([], animated: true)
    }
    
    private func createNav(with title:String, and image: UIImage?,vc: UIViewController)-> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title + "Controller"
    }
   

}
