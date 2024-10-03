//
//  ContentView.swift
//  MarvelApp
//
//  Created by Alberto Orrantia on 01/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CharacterViewModel()

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView("Loading characters...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                List(viewModel.characters) { character in
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        HStack {
                            AsyncImage(url: URL(string: character.thumbnailURL)) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                            } placeholder: {
                                ProgressView() // Placeholder while image loads
                            }
                            Text(character.name)
                                .font(.headline)
                                .padding(.leading, 10)
                        }
                    }
                }
                .navigationTitle("Marvel Characters")
            }
        }
        .onAppear {
            viewModel.fetchCharacters()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
