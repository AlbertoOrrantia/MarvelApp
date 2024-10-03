//
//  CharacterDetailView.swift
//  MarvelApp
//
//  Created by Alberto Orrantia on 02/10/24.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.thumbnailURL)) { image in image.resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(12)
            } placeholder: {
                ProgressView()
            }
            
            Text(character.name)
                .font(.largeTitle)
                .padding()
            
            Text(character.description.isEmpty ? "No description available" : character.description)
                .font(.body)
                .padding()
            Spacer()
        }
                .navigationBarTitle(character.name)
    }
}


