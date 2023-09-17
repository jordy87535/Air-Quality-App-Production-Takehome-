//
//  AQIModel.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/15/23.
//

import Foundation

struct NearestCityResponse: Codable {
    let status: String
    let data: CityData
}

struct CityData: Codable {
    let city: String
    let state: String
    let country: String
    let location: location
    let current: CurrentData
}

struct location: Codable {
    let type: String
    let coordinates: [Double]
}

struct CurrentData: Codable {
    let pollution: PollutionData
    let weather: WeatherData
}

struct PollutionData: Codable {
    let ts: String
    let aqius: Int
    let mainus: String
    let aqicn: Int
    let maincn: String
}

struct WeatherData: Codable {
    let ts: String
    let tp: Int
    let pr: Int
    let hu: Int
    let ws: Double
    let wd: Int
    let ic: String
}


