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
}
