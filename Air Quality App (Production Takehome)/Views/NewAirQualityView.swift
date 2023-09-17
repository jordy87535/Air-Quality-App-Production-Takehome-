//
//  AirQualityView.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/15/23.
//

import SwiftUI

struct NewAirQualityView: View {
    
    var city: CityDataModel?
    @StateObject private var vm: TrackAirQualityViewModel
    var latitude: Double?
    var longitude: Double?

    init(city: CityDataModel? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
        _vm = StateObject(wrappedValue: TrackAirQualityViewModel(city_input: city, latitude: latitude, longitude: longitude))
    }
    
    var body: some View {
        VStack {
            switch vm.state {
            case .idle:
                Text("No AQI to show. Please reload now ")
                
            case .loading:
                ProgressView()
                
            case .success(let cityData):
                
                    ScrollView {
                        HStack {
                            Text("My AQI")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button {
                                vm.changeState()
                            } label: {
                                Text(vm.is_favorite ? "Favorite" : "Unfavorite")
                            }
                        }
                        
                        VStack {
                            Text("\(cityData.city), \(cityData.state), \(cityData.country)")
                                .font(.headline)
                                .bold()
                                
                            Text("\(cityData.AQI)")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                            Text("IQR (US)")
                                .font(.footnote)
                            Text("Last updated: \(cityData.last_updated)")
                                .font(.footnote)
                        }
                        .frame(width: 200, height: 200)
                        .background(Color(.white))
                        .cornerRadius(30)
                        .shadow(color: Color.black.opacity(0.9), radius: 10, x: -10, y: 10)
                        
                        
                        VStack {
                            switch cityData.AQI {
                            case 0...50:
                                Text("Air Quality: Good ")
                            case 51...100:
                                Text("Air Quality: Moderate")
                            case 101...150:
                                Text("Air Quality: Unhealthy for Sensitive Groups")
                            default:
                                Text("Air Quality: Unhealthy")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(30)
                        
                        VStack(spacing: 20) {
                            Text("What Can You Do?")
                                .font(.largeTitle)
                            
                            switch cityData.AQI {
                            case 0...50:
                                Text("Go about your day as usual, no precautions necessary")
                            case 51...100:
                                Text("Consider outdoor exposure if you are especially sensitive")
                            case 101...150:
                                Text("If you have asthma or any other respiratory condition, avoid outdoor exposure")
                            default:
                                Text("You should limit your outdoor exposure, and if you have asthma or any other respiratory illness, stay inside")
                            }
                            
                            Link("Learn More", destination: URL(string: "https://www.cdc.gov/air/default.htm")!)
                        }
                        .frame(maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(30)
                        
                        Spacer()
                        
                    }
                    .padding()
                    .background(Color(red: 46/255, green: 29/255, blue: 156/255))
                    .refreshable {
                        vm.getNearestAQI(latitude: cityData.latitude, longitude: cityData.longitude)
                    }
                
            case .failed(let message):
                Text(message)
            }
        }
        //.onAppear(perform: vm.getLocation)
    }
}

struct NewAirQualityView_Previews: PreviewProvider {
    static var previews: some View {
        NewAirQualityView()
    }
}
