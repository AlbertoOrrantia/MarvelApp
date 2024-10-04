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
                // Search Bar
                TextField("Search characters", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray5))
                    .cornerRadius(25)
                    .padding(.horizontal, 10)

                if viewModel.isLoading {
                    ProgressView("Searching for characters...")
                        .padding(.top, 20)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    List(viewModel.filteredCharacters(searchText: searchText)) { character in
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
                                
                                Text(character.name)
                                    .font(.headline)
                                    .padding(.leading, 10)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Search Characters")
            .onAppear {
                viewModel.fetchCharacters()
            }
        }
    }
}
