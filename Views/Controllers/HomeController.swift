//
//  ViewController.swift
//  Earthquake Monitoring
//
//  Created by Gracie on 24/06/2024.

import UIKit



class HomeController: UIViewController {
//    @IBOutlet weak var tableView: UITableView!
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.text = """
 Welcome to the Earthquake Data App!

      Stay safe!

"""
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
    return label
        }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Welcome"
        view.addSubview(welcomeLabel)
     
        self.view.backgroundColor = .systemRed
      setlabelconstaints()
    }
    
    
    func setlabelconstaints(){
        NSLayoutConstraint.activate([
        welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        welcomeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        
        ])
        
        
        
    }
}

