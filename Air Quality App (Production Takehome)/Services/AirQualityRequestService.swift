//
//  AirQualityRequestService.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/14/23.
//

import Foundation


struct airQualityRequestService {
    var session = URLSession.shared
    var decoder = JSONDecoder()
    
    let IQAIR_API_KEY = "2b8335d5-ea51-4937-9e68-3e24e72b300d"
    
    
    func getAQI(latitude: Double, longitude: Double) async throws -> NearestCityResponse {
        
        print("https://api.airvisual.com/v2/nearest_city?lat=\(latitude)&lon=\(longitude)&key=\(IQAIR_API_KEY)")
        let components = URLComponents(string: "https://api.airvisual.com/v2/nearest_city?lat=\(latitude)&lon=\(longitude)&key=\(IQAIR_API_KEY)")
        guard let url = components?.url else {
            fatalError("URL IS INVALID - FatalError")
        }
        let (data, _) = try await session.data(from: url)
        let nearest_city = try decoder.decode(NearestCityResponse.self, from: data)
        
        return nearest_city
        
    }
    
    
    func getListOfCountries() async throws -> [String] {
        
        let components = URLComponents(string: "https://api.airvisual.com/v2/countries?key=\(IQAIR_API_KEY)")
        guard let url = components?.url else {
            fatalError("URL IS INVALID - FatalError")
        }
        let (data, _) = try await session.data(from: url)

        let countries_json = try decoder.decode(Countries.self, from: data)
        
        var countries: [String] = []
        for i in countries_json.data{
            countries.append(i.country)
        }
        return countries
    }
    
    
}
