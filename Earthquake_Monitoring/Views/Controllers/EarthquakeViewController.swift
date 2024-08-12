import UIKit
import RxSwift
import RxCocoa

class EarthquakeViewController: UIViewController {

    // ViewModel for handling earthquake data
    private let viewModel: EarthquakeViewModel

    // DisposeBag to manage memory for Rx subscriptions
    private let disposeBag = DisposeBag()

    // Search bar for filtering earthquakes by place
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search by place"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    // Table view for displaying earthquake data
    private let earthquakeTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // Initialize with the ViewModel
    init(viewModel: EarthquakeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // Required initializer for using this class in Interface Builder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        setupUI()
        setupBindings()
        
        // Trigger initial data fetch
        viewModel.fetchEarthquakes.onNext(())
    }

    // Set up the UI components
    private func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(earthquakeTableView)

        // Layout constraints
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            earthquakeTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            earthquakeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            earthquakeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            earthquakeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // Set up bindings between the ViewModel and UI components
    private func setupBindings() {
        // Bind search bar text to the ViewModel's search query
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchQuery)
            .disposed(by: disposeBag)

        // Bind fetched earthquakes to the table view cells
        viewModel.fetchedEarthquakes
            .observe(on: MainScheduler.instance)
            .bind(to: earthquakeTableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { _, earthquake, cell in
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = """
                Magnitude: \(earthquake.magnitude)
                Place: \(earthquake.place)
                Time: \(earthquake.time)
                Coordinates: \(earthquake.coordinates.latitude), \(earthquake.coordinates.longitude)
                """
            }
            .disposed(by: disposeBag)

        // Handle selection of a specific earthquake to show on the map
        earthquakeTableView.rx.modelSelected(Earthquake.self)
            .subscribe(onNext: { [weak self] earthquake in
                self?.showMapForEarthquake(earthquake)
            })
            .disposed(by: disposeBag)
    }

    // Show the map for the selected earthquake
    private func showMapForEarthquake(_ earthquake: Earthquake) {
        let mapViewController = MapViewController()
        mapViewController.earthquakes = [earthquake]
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}
