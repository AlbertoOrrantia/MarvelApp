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
        NavigationStack {
            if viewModel.isLoading && viewModel.characters.isEmpty {
                ProgressView("Loading characters...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.characters) { character in
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
                            .onTapGesture {
                                viewModel.selectedCharacter = character
                            }
                        }

                        if viewModel.isFetchingMore {
                            ProgressView("Loading more...")
                        } else {
                            Color.clear
                                .onAppear {
                                    viewModel.fetchCharacters()
                                }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Marvel Characters")
                .navigationDestination(
                    isPresented: Binding(
                        get: { viewModel.selectedCharacter != nil },
                        set: { _ in viewModel.selectedCharacter = nil }
                    ),
                    destination: {
                        CharacterDetailView(character: viewModel.selectedCharacter ?? viewModel.characters.first!)
                    }
                )
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
