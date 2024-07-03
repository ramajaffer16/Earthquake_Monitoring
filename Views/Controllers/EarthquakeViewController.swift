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

    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Earthquakes Data"
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


    private func showMapForEarthquake(_ earthquake: Earthquake) {
        let mapViewController = MapViewController()
        mapViewController.earthquake = earthquake
        navigationController?.pushViewController(mapViewController, animated: true)
    }

}
