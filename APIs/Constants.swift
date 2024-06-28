//
//  Constants.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 26/06/2024.
//

import Foundation

import Combine

class EarthquakeViewModel: ObservableObject {
    @Published var earthquakes: [Feature] = []
    private var cancellables: Set<AnyCancellable> = []

    func fetchEarthquakeData() {
        let urlString = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Earthquake.self, decoder: JSONDecoder())
            .map { $0.features }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.earthquakes = $0
            }
            .store(in: &cancellables)
    }
}
