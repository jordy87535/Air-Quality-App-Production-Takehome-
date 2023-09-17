//
//  FavoritesViewModel.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/15/23.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    
    @Published var favorites: [String: CityDataModel] = [:]
    @Published var data_list: [CityDataModel] = []
    @Published var is_favorited = false
    
    
    
    init() {
        loadFavorites()
    }

    func addEntry(city: String, city_data: CityDataModel) {
        favorites[city] = city_data
        saveFavorites()
    }

    func deleteEntry(city: String) {
        favorites[city] = nil
        saveFavorites()
    }
    
    func saveFavorites() {
        DispatchQueue.main.async {
            let encoder = PropertyListEncoder()
            if let encodedData = try? encoder.encode(self.favorites) {
                    UserDefaults.standard.set(encodedData, forKey: "favorites")
                }
        }
    }
    
    func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favorites") {
            let decoder = PropertyListDecoder()
            if let decodedDictionary = try? decoder.decode([String: CityDataModel].self, from: data) {
                
                /*
                for (key, value) in decodedDictionary {
                    var track = TrackAirQualityViewModel(city_input: value)
                    print("FIDJO")
                    switch track.state {
                    
                    case .success(let cityData):
                        print(":GJISODGJDS")
                        favorites[key] = cityData
                    default:
                        print("here")
                        break
                    }
                }
                 */
                favorites = decodedDictionary
            
                self.data_list = favorites.map { $0.value }
            }
        }
    }
    
    func getFavorites() -> [String: CityDataModel] {
        return favorites
    }
    
}
