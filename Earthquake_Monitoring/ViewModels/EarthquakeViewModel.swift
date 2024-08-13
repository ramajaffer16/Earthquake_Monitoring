//
//  EarthquakeViewModel.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 28/06/2024.
//


import Foundation
import RxSwift

class EarthquakeViewModel {
    
    private let earthquakeService: EarthquakeService
    private let disposeBag = DisposeBag()

    let fetchEarthquakes = PublishSubject<Void>()
    let searchQuery = PublishSubject<String>()

    let earthquakes = PublishSubject<[Earthquake]>()
    let fetchedEarthquakes = PublishSubject<[Earthquake]>()

    init(earthquakeService: EarthquakeService = EarthquakeService()) {
        self.earthquakeService = earthquakeService

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
        
        Observable.combineLatest(earthquakes, searchQuery) { earthquakes, query in
            return earthquakes.filter { earthquake in
                query.isEmpty || earthquake.place.lowercased().contains(query.lowercased())
            }
        }
        .bind(to: fetchedEarthquakes)
        .disposed(by: disposeBag)
    }
}
