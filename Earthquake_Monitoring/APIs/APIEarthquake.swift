//
//  Constants.swift
//  Earthquake_Monitoring
//

//

import RxSwift
import Foundation

class EarthquakeService {
    
    // Fetch earthquake data from the USGS API
    func fetchEarthquakes() -> Observable<[Earthquake]> {
        return Observable.create { observer in
            let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    // Handle error and notify observer
                    observer.onError(error)
                    return
                }
                
                // Ensure a valid HTTP response
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    observer.onError(NSError(domain: "HTTP Error", code: 500, userInfo: nil))
                    return
                }
                
                // Ensure data is available
                guard let data = data else {
                    observer.onError(NSError(domain: "Data Error", code: 500, userInfo: nil))
                    return
                }
                
                do {
                    // Decode JSON data into EarthquakeResponse
                    let earthquakeResponse = try JSONDecoder().decode(EarthquakeResponse.self, from: data)
                    
                    // Map features to Earthquake objects
                    let earthquakes = earthquakeResponse.features.map { feature -> Earthquake in
                        return Earthquake(
                            id: feature.id,
                            magnitude: feature.properties.mag,
                            place: feature.properties.place,
                            time: Date(timeIntervalSince1970: feature.properties.time / 1000),
                            coordinates: (feature.geometry.coordinates[1], feature.geometry.coordinates[0])
                        )
                    }
                    
                    // Notify observer of the fetched earthquakes
                    observer.onNext(earthquakes)
                    observer.onCompleted()
                    
                } catch {
                    // Handle JSON decoding errors
                    observer.onError(error)
                }
            }
            
            // Start the data task
            task.resume()
            
            // Return a disposable to cancel the task if needed
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
