//
//  AirQualityView.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/15/23.
//

import SwiftUI

struct AirQualityView: View {
    
    var city: CityDataModel?
    var latitude: Double?
    var longitude: Double?
    @StateObject private var vm: TrackAirQualityViewModel

    init(city: CityDataModel? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
        _vm = StateObject(wrappedValue: TrackAirQualityViewModel(city_input: city, latitude: latitude, longitude: longitude))
    }
    
    var body: some View {
        
        NavigationView {
            NavigationStack{
                VStack {
                    List {
                        Section{
                            Button("Reload"){
                                vm.getLocation()
                            }
                            /*
                            NavigationLink(destination: Favorites()) {
                                    Text("Next")
                                        .font(.headline)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            */
                        }
                        
                    switch vm.state {
                        case .idle :
                            Text("No AQI to show. Please reload now ")
                            
                        case .loading :
                            ProgressView()
                            
                        case .success(let cityData):
                            VStack {
                                Text("\(cityData.city), \(cityData.state), \(cityData.country)")
                                    .font(.largeTitle)
                                    .bold()
                                    
                                
                                HStack {
                                    Text("Air Quality: \(cityData.AQI)")
                                    Spacer()
                                }
                                .padding()
                                .background(Color(.gray))
                                .cornerRadius(20)
                                
                                Spacer()
                                Button("Favorite it") {
                                    vm.changeState()
                                }
                            }
                            .padding()
                            .background(Color(.blue))
                            
                        case .failed(let message):
                        Text(message)
                            
                        }
                    }
                }
                .navigationTitle("My AQI")
            }
        }
        
        
    }
    
    /*
    var body: some View {
        VStack {
            Text("Chapel Hill")
                .font(.largeTitle)
                .bold()
                
            
            HStack {
                Text("Air Quality: 0")
                Spacer()
            }
            .padding()
            .background(Color(.gray))
            .cornerRadius(20)
            
            Spacer()
        }
        .padding()
        .background(Color(.blue))
    }
    */
}

struct AirQualityView_Previews: PreviewProvider {
    static var previews: some View {
        AirQualityView()
    }
}
