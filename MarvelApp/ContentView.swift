//
//  ContentView.swift
//  MarvelApp
//
//  Created by Alberto Orrantia on 01/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CharacterViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView("Loading characters...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.characters) { character in
                            NavigationLink(destination: CharacterDetailView(character: character)) {
                                VStack {
                                    AsyncImage(url: URL(string: character.thumbnailURL)) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                    } placeholder: {
                                        ProgressView()
                                    }

                                    Text(character.name)
                                        .font(.headline)
                                        .padding(.top, 10)
                                }
                            }
                        }
                    }
                    .padding()
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
