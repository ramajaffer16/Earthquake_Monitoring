//
//  ViewController.swift
//  Earthquake Monitoring
//
//  Created by Gracie on 24/06/2024.


import UIKit

class HomeController: UIViewController {
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Next Controller", for: .normal)
        button.layer.cornerRadius = 7
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
       
    }

    private func setupUI(){
        self.view.backgroundColor = .systemBlue
    }
   
    @objc func didTapButton(){
    let vc = EarthquakeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

