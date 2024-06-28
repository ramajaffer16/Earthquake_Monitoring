//
//  Earthquake.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 26/06/2024.
//

import Foundation

// MARK: - Earthquake
struct Earthquake: Codable {
    let features: [Feature]
}

// MARK: - Feature
struct Feature: Codable {
    let properties: Properties
    let geometry: Geometry
}

// MARK: - Geometry
struct Geometry: Codable {
    let coordinates: [Double]
}

// MARK: - Properties
struct Properties: Codable {
    let mag: Double?
    let place: String?
    let time: Int?
}
