import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    var earthquakes: [Earthquake] = []
    
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        
        
        showEarthquakeLocationsOnMap()
        
        
        setupNavigation()
    }
    

    private func setupUI() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func setupNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func showEarthquakeLocationsOnMap() {
        guard !earthquakes.isEmpty else { return }
        
        for earthquake in earthquakes {
            let annotation = MKPointAnnotation()
            annotation.title = "\(earthquake.magnitude)"
            annotation.subtitle = earthquake.place
            annotation.coordinate = CLLocationCoordinate2D(latitude: earthquake.coordinates.latitude, longitude: earthquake.coordinates.longitude)
            mapView.addAnnotation(annotation)
        }
        
        
        if let firstEarthquake = earthquakes.first {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: firstEarthquake.coordinates.latitude, longitude: firstEarthquake.coordinates.longitude), latitudinalMeters: 1_000_000, longitudinalMeters: 1_000_000)
            mapView.setRegion(region, animated: true)
        }
    }
}
