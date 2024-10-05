//
//  MainTabView.swift
//  MarvelApp
//
//  Created by Alberto Orrantia on 03/10/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem { Image(systemName: "house.fill")
                    Text("Home") }
            
            SearchView()
                .tabItem { Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            FavoritesView()
                .tabItem { Image(systemName: "heart.fill")
                    Text("Favorites")
                }
        }
    }
}
