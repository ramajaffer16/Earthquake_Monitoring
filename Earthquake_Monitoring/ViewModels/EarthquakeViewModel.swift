//
//  EarthquakeViewModel.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 28/06/2024.
//


import Foundation
import RxSwift

class EarthquakeViewModel {
    
    // Dependencies
    private let earthquakeService: EarthquakeService
    private let disposeBag = DisposeBag()

    // Inputs
    let fetchEarthquakes = PublishSubject<Void>() // Trigger to fetch earthquakes
    let searchQuery = PublishSubject<String>() // User input for search query

    // Outputs
    let earthquakes = PublishSubject<[Earthquake]>() // All fetched earthquakes
    let fetchedEarthquakes = PublishSubject<[Earthquake]>() // Filtered earthquakes based on search query

    init(earthquakeService: EarthquakeService = EarthquakeService()) {
        self.earthquakeService = earthquakeService

        // Fetch earthquakes when triggered
        fetchEarthquakes
            .flatMapLatest { _ in
                earthquakeService.fetchEarthquakes()
                    .catch { error in
                        print("Error fetching earthquakes: \(error.localizedDescription)")
                        return Observable.just([])
                    }
            }
            .bind(to: earthquakes)
            .disposed(by: disposeBag)
        
        // Combine earthquakes and searchQuery observables to filter results
        Observable.combineLatest(earthquakes, searchQuery) { earthquakes, query in
            return earthquakes.filter { earthquake in
                query.isEmpty || earthquake.place.lowercased().contains(query.lowercased())
            }
        }
        .bind(to: fetchedEarthquakes)
        .disposed(by: disposeBag)
    }
}
