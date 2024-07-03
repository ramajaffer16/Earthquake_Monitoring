//
//  ViewController.swift
//  Earthquake Monitoring
//
//  Created by Gracie on 24/06/2024.

import UIKit


//import UIKit
//
//class HomeController: UIViewController {
//    private let button: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .systemBlue
//        button.setTitle("Next Controller", for: .normal)
//        button.layer.cornerRadius = 7
//        return button
//    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.setupUI()
//       
//    }
//
//    private func setupUI(){
//        self.view.backgroundColor = .systemBlue
//    }
//   
//    @objc func didTapButton(){
//    let vc = EarthquakeViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
//        
//    }
//}
class HomeController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
//    var viewModel: EarthquakeViewModel!
//    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel = EarthquakeViewModel(apiService: APIService.self as! APIService)
        self.view.backgroundColor = .systemRed
        
        // Initialize your table view here
//        tableView = UITableView(frame: view.bounds)
//        view.addSubview(tableView)
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        
//        // Register your cells
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.earthquakes.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let earthquake = viewModel.earthquakes[indexPath.row]
//        cell.textLabel?.text = "\(earthquake.title): \(earthquake.location)"
//        return cell
//    }
//}
//
//
