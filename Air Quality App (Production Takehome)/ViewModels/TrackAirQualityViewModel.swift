//
//  TrackAirQualityViewModel.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/14/23.
//

import Foundation

class TrackAirQualityViewModel: ObservableObject {
    private let service = airQualityRequestService()
    private let locationManager = LocationManager()
    @Published var state: AQILoadingState = .idle
    @Published var favorites: [String: CityDataModel] = [:]
    @Published var is_favorite = false
    var city_input: CityDataModel?
    var latitude: Double?
    var longitude: Double?
    
    init(city_input: CityDataModel? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        if let input_city = city_input {
            getNearestAQI(latitude: input_city.latitude, longitude: input_city.longitude)
        }
        if var lat = latitude, var long = longitude {
            lat += 0.0001
            long += 0.0001
            
            getNearestAQI(latitude: lat, longitude: long)
        }
        else {
            locationManager.delegate = self
            getLocation()
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy HH:mm a" // Customize the date format as needed
        dateFormatter.locale = Locale(identifier: "en_US") // Set the locale for the date format
        
        return dateFormatter.string(from: date)
    }
    
    func getLocation() {
        state = .loading
        locationManager.requestLocation()
    }
    
    func checkFavorite() -> Bool {
        loadFavorites()
        switch state {
        case .success(let cityData):
            if let _ = favorites[cityData.city] {
                is_favorite = true
                return true
            }
            else {
                is_favorite = false
                return false
            }
        default:
            is_favorite = false
            return false
        }
    }
    
    func changeState() {
        if checkFavorite() {
            deleteEntry()
        }
        else {
            addEntry()
        }
    }
    
    func addEntry() {
        switch state {
        case .success(let cityData):
            print("Add entry")
            favorites[cityData.city] = cityData
            saveFavorites()
        default:
            break
        }
    }

    func deleteEntry() {
        switch state {
        case .success(let cityData):
            print("Delete entry")
            favorites[cityData.city] = nil
            saveFavorites()
        default:
            break
        }
    }
    
    func saveFavorites() {
        DispatchQueue.main.async {
            let encoder = PropertyListEncoder()
            if let encodedData = try? encoder.encode(self.favorites) {
                print("Saved data")
                UserDefaults.standard.set(encodedData, forKey: "favorites")
            }
        }
    }
    
    func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favorites") {
            let decoder = PropertyListDecoder()
            if let decodedDictionary = try? decoder.decode([String: CityDataModel].self, from: data) {
                favorites = decodedDictionary
            }
        }
    }
    
    func assignCityData(city: String, state: String, country: String, AQI: Int, latitude: Double, longitude: Double) -> CityDataModel {
        return CityDataModel(city: city, state: state, country: country, last_updated: formatDate(Date()), AQI: AQI, latitude: latitude, longitude: longitude)
    }
    
    public func getNearestAQI(latitude: Double, longitude: Double) {
        Task {
            do {
                let temp = try await service.getAQI(latitude: latitude, longitude: longitude)
                DispatchQueue.main.async {
                    self.state = .success(self.assignCityData(city: temp.data.city, state: temp.data.state, country: temp.data.country, AQI: temp.data.current.pollution.aqius, latitude: latitude, longitude: longitude))
                }
            }
            catch {
                print("\(error)")
                DispatchQueue.main.async {
                    self.state = .failed(message: "Error getting data from server")
                }
            }
        }
    }
    
    public func getListOfCountries() {
        Task {
            do {
                let temp = try await service.getListOfCountries()
                print(temp)
            }
            catch {
                print("\(error)")
            }
        }
    }
}

extension TrackAirQualityViewModel: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: Location) {
        print(location)
        print(location.latitude, location.longitude)
        getNearestAQI(latitude: location.latitude, longitude: location.longitude)
    }
    
    func locationManager(_ manager: LocationManager, didFailError error: Error) {
        state = .failed(message: error.localizedDescription)
        print(error.localizedDescription)
    }
}
