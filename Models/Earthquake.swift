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
}

// MARK: - Properties
struct Properties: Codable {
    let place: String
    let mag: Double
}
