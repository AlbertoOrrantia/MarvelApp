//
//  FavoritesView.swift
//  MarvelApp
//
//  Created by Alberto Orrantia on 03/10/24.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.favoriteCharacters.isEmpty {
                    Text("Add Your Favorite Characters!")
                        .font(.headline)
                        .padding(10)
                } else {
                    List {
                        ForEach(viewModel.favoriteCharacters, id: \.self) { favorite in
                            HStack {
                                AsyncImage(url: URL(string: favorite.thumbnailURL ?? "")) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                }
                                
                                Text(favorite.name ??  "")
                                    .font(.headline)
                                    .padding(.leading, 10)
                                Spacer()
                                Button(action: {
                                    viewModel.removeFavorite(character: favorite)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                viewModel.fetchFavorites()
            }
            
        }
    }
}

