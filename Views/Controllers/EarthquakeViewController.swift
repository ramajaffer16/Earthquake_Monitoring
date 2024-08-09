//
//  EarthquakeViewController.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 26/06/2024.



import UIKit
import RxSwift
import RxCocoa

class EarthquakeViewController: UIViewController {
    var viewModel: EarthquakeViewModel
    
    init(viewModel: EarthquakeViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let disposeBag = DisposeBag()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search by place"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
        
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
//        NavigationBarItem.title = "Welcome"
//        title = "Earthquakes Data"
        setupUI()
        setupBindings()
        viewModel.fetchEarthquakes.onNext(())
//        showAlert()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showAlert()
    }

    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: view.topAnchor),
                                     searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor)
                                    ])
    }
    func showAlert() {
            let alert = UIAlertController(title: "Ready to view earthquake data?", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [weak self] _ in
                self?.navigateToEarthquakeViewController()
            }))
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
        }

    private func setupBindings() {
        viewModel.earthquakes
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.numberOfLines = 0  // Allow multiline text in cell
                cell.textLabel?.text = """
                Magnitude: \(element.magnitude)
                Place: \(element.place)
                Time: \(element.time)
                Coordinates: \(element.coordinates.latitude), \(element.coordinates.longitude)
                """
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Earthquake.self)
            .subscribe(onNext: { [weak self] earthquake in
                self?.showMapForEarthquake(earthquake)
            })
            .disposed(by: disposeBag)
    }
    func navigateToEarthquakeViewController() {
            let viewModel = EarthquakeViewModel()
            let earthquakeViewController = EarthquakeViewController(viewModel: viewModel)
            navigationController?.pushViewController(earthquakeViewController, animated: true)
        }

    private func showMapForEarthquake(_ earthquake: Earthquake) {
        let mapViewController =
        MapViewController()
        mapViewController.earthquake = earthquake
        navigationController?.pushViewController(mapViewController, animated: true)
    }

}
