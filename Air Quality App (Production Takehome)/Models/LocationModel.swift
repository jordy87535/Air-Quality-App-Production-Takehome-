//
//  LocationModel.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/15/23.
//

import Foundation


struct Location {
    let latitude: Double
    let longitude: Double
}

extension Location: CustomStringConvertible {
    var description: String {
        return "Latitude: \(latitude), Longitude: \(longitude)"
    }
}

