import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // Property to hold the earthquake data passed from the previous view controller
    var earthquakes: [Earthquake] = []
    
    // Map view to display the earthquake location
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the UI elements and constraints
        setupUI()
        
        // Show all earthquake locations on the map
        showEarthquakeLocationsOnMap()
        
        // Set up the navigation bar
        setupNavigation()
    }
    
    // Function to set up the map view constraints
    private func setupUI() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Function to configure the navigation bar with a back button
    private func setupNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    // Action for the back button to navigate back to the previous screen
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // Function to show the earthquake locations on the map using annotations
    private func showEarthquakeLocationsOnMap() {
        guard !earthquakes.isEmpty else { return }
        
        for earthquake in earthquakes {
            let annotation = MKPointAnnotation()
            annotation.title = "\(earthquake.magnitude)"
            annotation.subtitle = earthquake.place
            annotation.coordinate = CLLocationCoordinate2D(latitude: earthquake.coordinates.latitude, longitude: earthquake.coordinates.longitude)
            mapView.addAnnotation(annotation)
        }
        
        // Optionally, you can set the map region to encompass all the earthquakes
        if let firstEarthquake = earthquakes.first {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: firstEarthquake.coordinates.latitude, longitude: firstEarthquake.coordinates.longitude), latitudinalMeters: 1_000_000, longitudinalMeters: 1_000_000)
            mapView.setRegion(region, animated: true)
        }
    }
}
