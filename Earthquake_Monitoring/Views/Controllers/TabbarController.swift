import UIKit

class TabbarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        selectedIndex = 2
        tabBar.tintColor = .green
        tabBar.unselectedItemTintColor = .purple
        delegate = self
        customizeTabBarAppearance()
    }

    private func setupTabs() {
        let homeController = HomeController()
        let viewModel = EarthquakeViewModel()
        let earthquakeViewController = EarthquakeViewController(viewModel: viewModel)

        let homeNavController = createNavController(withTitle: "Home", image: UIImage(systemName: "house"), viewController: homeController)
        let historyNavController = createNavController(withTitle: "Earthquake History", image: UIImage(systemName: "clock"), viewController: earthquakeViewController)

        setViewControllers([homeNavController, historyNavController], animated: true)
    }

    private func createNavController(withTitle title: String, image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image

        if let firstController = navController.viewControllers.first {
            firstController.navigationItem.title = "QuakeWatch"
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.systemGreen]
            navController.navigationBar.standardAppearance = appearance
        } else {
            print("No view controller found")
        }
        
        // Debugging to see why I cant access second controller
//        if navController.viewControllers.count > 1 {
//               let secondController = navController.viewControllers[1]
//               print("Second view controller found: \(secondController)")
//           } else {
//               print("No second view controller found")
//           }
//
           return navController
       }

       
    private func customizeTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .brown
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let alert = UIAlertController(title: "Switching Tab", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        return true
    }
    
}
