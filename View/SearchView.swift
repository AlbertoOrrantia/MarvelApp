//
//  SearchView.swift
//  MarvelApp
//
//  Created by Alberto Orrantia on 03/10/24.
//

import SwiftUI

//Implement a search bar using Textfield
struct SearchView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = CharacterViewModel()
    
    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            if viewModel.isLoading {
                ProgressView("Searching for characters...")
            } else {
                List(viewModel.characters.filter {
                    $0.name.lowercased().contains(searchText.lowercased()) || searchText.isEmpty}) { character in
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
        }
        .onAppear {
            viewModel.fetchCharacters()
        }
    }
    }


