import UIKit
import RxSwift
import RxCocoa

class EarthquakeViewController: UIViewController {

    
    private let viewModel: EarthquakeViewModel

    
    private let disposeBag = DisposeBag()

    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search by place"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()


    private let earthquakeTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    
    init(viewModel: EarthquakeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        setupUI()
        setupBindings()
        
    
        viewModel.fetchEarthquakes.onNext(())
    }

    
    private func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(earthquakeTableView)


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

    
    private func setupBindings() {
        
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchQuery)
            .disposed(by: disposeBag)

        
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


        earthquakeTableView.rx.modelSelected(Earthquake.self)
            .subscribe(onNext: { [weak self] earthquake in
                self?.showMapForEarthquake(earthquake)
            })
            .disposed(by: disposeBag)
    }

    
    private func showMapForEarthquake(_ earthquake: Earthquake) {
        let mapViewController = MapViewController()
        mapViewController.earthquakes = [earthquake]
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}
