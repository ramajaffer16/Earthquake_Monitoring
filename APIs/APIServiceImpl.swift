//
//  APIServiceImpl.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 01/07/2024.
//

// APIServiceImpl.swift
//import Foundation
//import RxSwift
//
//class APIServiceImpl: APIService {
//    func fetchEarthquakes() -> Observable<[Earthquake]> {
//        // Implement API request using URLSession or Alamofire
//        guard let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson") else {
//            return Observable.just([]) // Return empty if URL is invalid
//        }
//        
//        return URLSession.shared.rx.data(request: URLRequest(url: url))
//            .map { data -> [Earthquake] in
//                let decoder = JSONDecoder()
//                guard let response = try? decoder.decode(USGSEarthquakeResponse.self, from: data) else {
//                    return []
//                }
//                return response.features.map { feature in
//                    let id = feature.id
//                    let magnitude = feature.properties.mag
//                    let place = feature.properties.place
//                    let time = Date(timeIntervalSince1970: TimeInterval(feature.properties.time) / 1000.0)
//                    let latitude = feature.geometry.coordinates[1]
//                    let longitude = feature.geometry.coordinates[0]
//                    return Earthquake(id: id, magnitude: magnitude, place: place, time: time, latitude: latitude, longitude: longitude)
//                }
//            }
//            .catchAndReturn([]) // Handle errors
//            .asObservable()
//    }
//}
//
//// Helper structs for parsing JSON response
//struct USGSEarthquakeResponse: Codable {
//    let features: [USGSEarthquakeFeature]
//}
//
//struct USGSEarthquakeFeature: Codable {
//    let id: String
//    let properties: USGSEarthquakeProperties
//    let geometry: USGSEarthquakeGeometry
//}
//
//struct USGSEarthquakeProperties: Codable {
//    let mag: Double
//    let place: String
//    let time: Int
//}
//
//struct USGSEarthquakeGeometry: Codable {
//    let coordinates: [Double]
//}
