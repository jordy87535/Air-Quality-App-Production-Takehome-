//
//  AQILoadingState.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/16/23.
//

import Foundation

enum AQILoadingState {
    case idle
    case loading
    case success(CityDataModel)
    case failed(message: String)
}
