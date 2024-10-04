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
    private var totalCharacters: Int?

    func fetchCharacters() {
        if isFetchingMore { return } 
        isFetchingMore = true
        
        apiClient.fetchCharacters(limit: limit, offset: offset) { [weak self] result, total in
            DispatchQueue.main.async {
                if let result = result {
                    self?.characters.append(contentsOf: result)
                    self?.offset += self?.limit ?? 0
                    self?.totalCharacters = total
                    self?.isLoading = false
                } else {
                    self?.errorMessage = "Failed to load, Please try again later."
                    self?.isLoading = false
                }
                self?.isFetchingMore = false
            }
        }
    }

    func fetchCharactersByName(_ name: String) {
        isLoading = true
        apiClient.fetchCharactersByName(name: name) { [weak self] result in
            DispatchQueue.main.async {
                if let result = result {
                    self?.characters = result
                    self?.isLoading = false
                } else {
                    self?.errorMessage = "Failed to load characters."
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

    func loadMoreCharactersIfNeeded(currentCharacter: Character) {
        guard let lastCharacter = characters.last else {
            return
        }
        if currentCharacter.id == lastCharacter.id, let totalCharacters = totalCharacters, characters.count < totalCharacters {
            fetchCharacters()
        }
    }
}
