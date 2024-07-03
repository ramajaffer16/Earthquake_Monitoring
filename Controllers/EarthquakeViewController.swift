//
//  EarthquakeViewController.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 26/06/2024.


//import UIKit
//import RxSwift
//
//class EarthquakeViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .systemPink
//
//       
//    }
//    
//
//   
//
//}
import UIKit
import RxSwift


import RxCocoa

// EarthquakeListViewController.swift
// EarthquakeListViewController.swift
import UIKit
import RxSwift
import RxCocoa

class EarthquakeViewController: UIViewController {
    var viewModel: EarthquakeViewModel
       
       init(viewModel: EarthquakeViewModel) {
           self.viewModel = viewModel
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    private let disposeBag = DisposeBag()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.fetchEarthquakes.onNext(())
    }

    private func setupUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.earthquakes
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = "\(element.magnitude) - \(element.place)"
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Earthquake.self)
            .subscribe(onNext: { earthquake in
                // Handle selection if needed
            })
            .disposed(by: disposeBag)
    }
}
