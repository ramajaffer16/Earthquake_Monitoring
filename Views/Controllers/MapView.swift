//
//  MapView.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 03/07/2024.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var earthquake: Earthquake?

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let earthquake = earthquake {
            showEarthquakeLocationOnMap(earthquake)
        }
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

    private func showEarthquakeLocationOnMap(_ earthquake: Earthquake) {
        let annotation = MKPointAnnotation()
        annotation.title = "\(earthquake.magnitude)"
        annotation.subtitle = earthquake.place
        annotation.coordinate = CLLocationCoordinate2D(latitude: earthquake.coordinates.latitude, longitude: earthquake.coordinates.longitude)
        mapView.addAnnotation(annotation)

        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000)
        mapView.setRegion(region, animated: true)
    }
}
