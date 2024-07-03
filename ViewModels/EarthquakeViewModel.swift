//
//  EarthquakeViewModel.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 28/06/2024.
//

//import Foundation
//import Combine
//
//class EarthquakeViewModel: ObservableObject {
//    @Published var earthquakes: [Feature] = []
//    private var cancellables: Set<AnyCancellable> = []
//
//    func fetchEarthquakeData() {
//        let urlString = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//        
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: Earthquake.self, decoder: JSONDecoder())
//            .map { $0.features }
//            .replaceError(with: [])
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] in
//                self?.earthquakes = $0
//            }
//            .store(in: &cancellables)
//    }
//}
// EarthquakeListViewModel.swift
// EarthquakeViewModel.swift
import Foundation
import RxSwift
import RxCocoa

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
