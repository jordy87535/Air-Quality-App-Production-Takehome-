//
//  ContentView.swift
//  Air Quality App (Production Takehome)
//
//  Created by Jordan Becker on 9/14/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0

    var body: some View {
        VStack {
            TabView(selection: $selection) {
                NewAirQualityView()
                    .tabItem {
                        Text("Local")
                        Image(systemName: "house")
                    }
                    .tag(0)
                
                SearchView()
                    .navigationTitle("Search Coordinates")
                    .tabItem {
                        Text("Search")
                        Image(systemName: "magnifyingglass")
                    }
                    .tag(1)

                FavoritesView()
                    .tabItem {
                        Text("Favorites")
                        Image(systemName: "heart")
                    }
                    .tag(2)
                
                
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
