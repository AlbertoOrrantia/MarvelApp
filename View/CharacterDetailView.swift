//
//  CharacterDetailView.swift
//  MarvelApp
//
//  Created by Alberto Orrantia on 02/10/24.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject var favoritesViewModel = FavoritesViewModel()
    var character: Character
    @State private var isFavorited: Bool = false
    @State private var animationScale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.thumbnailURL)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
            } placeholder: {
                ProgressView()
            }

            Text(character.name)
                .font(.largeTitle)
                .padding()

            Text(character.description.isEmpty ? "No description available" : character.description)
                .font(.body)
                .padding()

            Button(action: {
                withAnimation(.spring()) {
                    if isFavorited {
                        // Remove from favorites
                        if let favorite = favoritesViewModel.favoriteCharacters.first(where: { $0.characterID == String(character.id) }) {
                            favoritesViewModel.removeFavorite(character: favorite)
                            isFavorited = false
                            animationScale = 1.0
                        }
                    } else {
                        // Add to favorites
                        favoritesViewModel.addFavorite(character: character)
                        isFavorited = true
                        animationScale = 1.2
                    }
                }
            }) {
                HStack {
                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                    Text(isFavorited ? "Added to Favorites" : "Add to Favorites")
                }
                .padding()
                .background(isFavorited ? Color.green : Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .scaleEffect(animationScale)
                .animation(.easeInOut(duration: 0.2), value: animationScale)
            }
            
            Spacer()
        }
        .navigationTitle(character.name)
        .onAppear {
            if favoritesViewModel.favoriteCharacters.contains(where: { $0.characterID == String(character.id) }) {
                isFavorited = true
            }
        }
    }
}


