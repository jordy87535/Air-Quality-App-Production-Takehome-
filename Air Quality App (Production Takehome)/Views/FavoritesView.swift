//
//  Favorites.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/15/23.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var vm = FavoritesViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("My Favorites")
                    .font(.largeTitle)
                List {
                    ForEach(vm.data_list, id: \.self) { city in
                        
                        NavigationLink(destination: NewAirQualityView(city: city)) {
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    VStack {
                                        Text(city.city)
                                            .font(.headline)
                                        HStack {
                                            Text("\(city.state), \(city.country)")
                                                .font(.footnote)
                                        }
                                    }

                                    Spacer()

                                    Text("AQI: \(city.AQI)")
                                }
                                .padding(.vertical)

                                Text("Last Updated: \(city.last_updated)")
                                    .font(.footnote)
                            }
                            .padding()
                        }
                    }
                }
                .refreshable {
                    vm.loadFavorites()
                }
            }
        }
        .onAppear {
            vm.loadFavorites()
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
