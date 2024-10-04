//
//  CharacterViewModel.swift
//  MarvelApp
//
//  Created by Alberto Orrantia on 02/10/24.
//

import Foundation


class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = true
    @Published var errorMessage: String?
    @Published var selectedCharacter: Character?
    
    private let apiClient = MarvelAPIDataClient()

    func fetchCharacters() {
        apiClient.fetchCharacters { [weak self] result in
            DispatchQueue.main.async {
                if let result = result {
                    self?.characters = result
                    self?.isLoading = false
                } else {
                    self?.errorMessage = "Failed to load, Please try again later."
                    self?.isLoading = false
                }
            }
        }
    }

    func filteredCharacters(searchText: String) -> [Character] {
        if searchText.isEmpty {
            return characters
        } else {
            return characters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}

