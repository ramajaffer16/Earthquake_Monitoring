
//
//  TabbarController.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 26/06/2024.
//

import UIKit

class TabbarController: UITabBarController, UITabBarControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
        self.selectedIndex = 2
        
        // change the background of the tabbar
//        self.tabBar.barTintColor = UIColor.red
        
        // change the icon and the title color
        self.tabBar.tintColor = UIColor.green
        
        let homeController = HomeController()
        let earthquakeViewController = EarthquakeViewController(viewModel: EarthquakeViewModel())
        
        homeController.tabBarItem.title = "Welcome Rama"
        earthquakeViewController.tabBarItem.title = "Earthquake"
        
        self.tabBar.unselectedItemTintColor = UIColor.purple
        
        self.delegate = self

        
    }
    
    private func setupTabs(){
        let homeController = HomeController()
        let viewModel = EarthquakeViewModel()
        
        let earthquakeViewController = EarthquakeViewController(viewModel: viewModel)
            
        let home = createNav(with: "Home", and: UIImage(systemName: "house"), vc: homeController)
        let history = createNav(with: "EarthquakeHistory", and: UIImage(systemName: "clock"), vc: earthquakeViewController)
        
        
        self.setViewControllers([home,history], animated: true)
    }
    
    private func createNav(with title:String, and image: UIImage?,vc: UIViewController)-> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        if nav.viewControllers.count > 0 {
            nav.viewControllers[0].navigationItem.title = "Welcome"
            
            let appearance = UINavigationBarAppearance()
//                    appearance.configureWithOpaqueBackground()
                    appearance.titleTextAttributes = [.foregroundColor: UIColor.systemGreen]
                    nav.navigationBar.standardAppearance = appearance
                    nav.navigationBar.scrollEdgeAppearance = appearance
            
        
            if nav.viewControllers.count > 1 {
                nav.viewControllers[1].navigationItem.title = "Salma"
            }else {
                print("No second View controller")
            }
        }else {
            print("No view Controller")
        }
        return nav
        //in this func I dont know why I cant access the second view controller
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect
                          viewContoller: UIViewController){
       
        if self.selectedIndex == 1 {
            let alert = UIAlertController(title: "View Eathquake data", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
   

}






