//
//  Constants.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 26/06/2024.
//

import Foundation

protocol USGSEarthquakeAPIRequest{
    var method: HTTPMethod {get}
    var path: String {get}
    var queryItems: [URLQueryParameter] {get}
}

enum HTTPMethod: String {
    case GET = "GET"
}

extension USGSEarthquakeAPIRequest {
    func request(with baseURL:URL)-> URLRequest {
        
    }
}

struct URLQueryParameter: Equatable {
    let key: String
    let value: String
}

struct EarthQueryParameter: CustomStringConvertible{
    let key: String
    let value: String
    
    var description: String{
        return "\(key)=\(value)"
    }
}

struct latestEarthquakesRequest: USGSEarthquakeAPIRequest{
    var method = HTTPMethod.GET
    var path = ""
    var queryItems: [URLQueryParameter] = [
    URLQueryParameter
    ]
}
