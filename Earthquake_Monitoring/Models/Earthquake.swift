//
//  Earthquake.swift
//  Earthquake_Monitoring
//
//  Created by Gracie on 26/06/2024.
//

import Foundation
import RxSwift


struct Earthquake {
    let id: String
    let magnitude: Double
    let place: String
    let time: Date
    let coordinates: (latitude: Double, longitude: Double)
}
