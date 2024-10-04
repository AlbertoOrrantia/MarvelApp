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
    @Published var isFetchingMore = false
    
    private let apiClient = MarvelAPIDataClient()
    private var offset = 0
    private let limit = 20

    func fetchCharacters() {
        if isFetchingMore { return }
        isFetchingMore = true
        
        apiClient.fetchCharacters(limit: limit, offset: offset) { [weak self] result in
            DispatchQueue.main.async {
                if let result = result {
                    self?.characters.append(contentsOf: result)
                    self?.offset += self?.limit ?? 0
                    self?.isLoading = false
                } else {
                    self?.errorMessage = "Failed to load, Please try again later."
                    self?.isLoading = false
                }
                self?.isFetchingMore = false
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

