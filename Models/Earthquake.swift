//
//  Earthquake.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 26/06/2024.
//

import Foundation

struct Earthquake: Codable {
    let id: Int
    let title: String
    let location: String
    let magnitude: Double
    let depth: Double
    let time: Date
}
