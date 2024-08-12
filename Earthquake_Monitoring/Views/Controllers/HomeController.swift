import UIKit
import RxSwift

class HomeController: UIViewController {

    private let disposeBag = DisposeBag()
    private let viewModel = EarthquakeViewModel()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = """
        Welcome to the Earthquake Data App!
        Stay safe!

        View All Earthquakes
        """
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let navigateButton: UIButton = {
        let button = UIButton()
        button.setTitle("CLICK HERE", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        setupUI()
        navigateButton.addTarget(self, action: #selector(navigateToEarthquake), for: .touchUpInside)
    }

    private func setupUI() {
        view.addSubview(welcomeLabel)
        view.addSubview(navigateButton)

        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            navigateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navigateButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20)
        ])
    }

    // Fetch the earthquakes from view mpodel and push to map view controller for dispaly
    @objc private func navigateToEarthquake() {
        viewModel.fetchEarthquakes.onNext(())

        viewModel.earthquakes
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] earthquakes in
                guard let self = self, !earthquakes.isEmpty else {
                    print("No earthquakes found.")
                    return
                }
                let mapViewController = MapViewController()
                mapViewController.earthquakes = earthquakes
                self.navigationController?.pushViewController(mapViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
