//
//  LocationViewModel.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/15/23.
//

import Foundation

enum LocationLoadingState {
    case idle
    case loading
    case success(location: Location)
    case error(message: String)
}

class LocationViewModel: ObservableObject {
    private let locationManager = LocationManager()
    
    @Published var state: LocationLoadingState = .idle
    
    init() {
        locationManager.delegate = self
    }
    
    func requestLocation() {
        state = .loading
        locationManager.requestLocation()
    }
}

extension LocationViewModel: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: Location) {
        state = .success(location: location)
    }
    
    func locationManager(_ manager: LocationManager, didFailError error: Error) {
        state = .error(message: error.localizedDescription)
    }
}
