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

    // Inputs
    let fetchEarthquakes = PublishSubject<Void>()

    // Outputs
    let earthquakes = PublishSubject<[Earthquake]>()

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
    }
}
