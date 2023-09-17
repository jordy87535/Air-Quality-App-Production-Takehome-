//
//  SearchView.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/17/23.
//

import SwiftUI

struct SearchView: View {
    @State private var latitudeQuery = ""
    @State private var longitudeQuery = ""
    @StateObject var vm = TrackAirQualityViewModel()
    @State private var isSearching = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                TextField("Enter Latitude", text: $latitudeQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Enter Longitude", text: $longitudeQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if let latitude = Double(latitudeQuery), let longitude = Double(longitudeQuery) {
                    
                    NavigationLink("Here", destination: NewAirQualityView(latitude: Double(latitudeQuery), longitude: Double(longitudeQuery)), isActive: $isSearching)
                }
                Button("Search") {
                    
                    if let latitude = Double(latitudeQuery), let longitude = Double(longitudeQuery) {
                        
                        if -90 <= latitude && latitude <= 90 && -180 <= longitude && longitude <= 180 {
                            NavigationLink("AQI there", destination: NewAirQualityView(city: nil, latitude: latitude, longitude: longitude))
                        }
                        
                        print("Latitude: \(latitude), Longitude: \(longitude)")
                    } else {
                        
                        print("Invalid latitude or longitude input")
                    }
                }
                .padding()
            }
            .padding()
        }
    }
}

