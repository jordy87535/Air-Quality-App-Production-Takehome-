//
//  CityDataModel.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/15/23.
//

import Foundation

struct CityDataModel: Codable, Identifiable, Equatable, Hashable {
    var id = UUID()
    var city: String
    var state: String
    var country: String
    var last_updated: String
    var AQI: Int
    var latitude: Double
    var longitude: Double
    
}
