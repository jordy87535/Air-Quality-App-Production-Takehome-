//
//  CountriesModel.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/14/23.
//

import Foundation


struct Countries: Codable, Hashable {
    var status: String
    var data: [Country]
}

struct Country: Codable, Hashable {
    var country: String
}

/*
struct States: Codable, Hashable {
    var status: String
    var data: [State]
}

struct State: Codable, Hashable {
    var state: String?
}

struct Cities: Codable, Hashable {
    var status: String
    var data: [City]
}

struct City: Codable, Hashable {
    var city: String
}
*/

