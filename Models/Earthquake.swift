//
//  Earthquake.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 26/06/2024.
//
// This is the simple structure of the my Earthquake Application

import Foundation
import RxSwift

// Define Earthquake structure
struct Earthquake {
    let id: String
    let magnitude: Double
    let place: String
    let time: Date
    let coordinates: (latitude: Double, longitude: Double)
}
