//
//  SearchView.swift
//  MarvelApp
//
//  Created by Alberto Orrantia on 03/10/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = CharacterViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search characters", text: $searchText, onCommit: {
                    searchCharacters()
                })
                .padding(10)
                .background(Color(.systemGray5))
                .cornerRadius(25)
                .padding(.horizontal, 10)
                .padding(.top, 10)

                ScrollView {
                    if viewModel.isLoading {
                        ProgressView("Searching for characters...")
                            .padding(.top, 20)
                    } else if let errorMessage = viewModel.errorMessage {
                        Text("Error: \(errorMessage)")
                    } else {
                        LazyVStack {
                            ForEach(viewModel.characters) { character in
                                NavigationLink(destination: CharacterDetailView(character: character)) {
                                    HStack {
                                        AsyncImage(url: URL(string: character.thumbnailURL)) { image in
                                            image.resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(8)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        Spacer(minLength: 20)

                                        Text(character.name)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 20)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search Characters")
            .onAppear {
                viewModel.fetchCharacters()
            }
        }
    }

    func searchCharacters() {
        if !searchText.isEmpty {
            viewModel.fetchCharactersByName(searchText)
        } else {
            viewModel.characters.removeAll()
        }
    }
}
