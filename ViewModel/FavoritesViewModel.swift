//
//  FavoritesViewModel.swift
//  MarvelApp
//
//  Created by Alberto Orrantia on 04/10/24.
//

import Foundation
import CoreData

class FavoritesViewModel: ObservableObject {
    @Published var favoriteCharacters: [FavoriteCharacter] = []
    
    let viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    func addFavorite(character: Character) {
        let newFavorite = FavoriteCharacter(context: viewContext)
        newFavorite.characterID = String(character.id)
        newFavorite.name = character.name
        newFavorite.thumbnailURL = character.thumbnailURL
        
        saveContext()
        fetchFavorites()
    }
    
    func fetchFavorites() {
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        do {
            favoriteCharacters = try viewContext.fetch(request)
        } catch {
            print("Failed to fetch favorites: \(error)")
        }
    }

    func removeFavorite(character: FavoriteCharacter) {
        viewContext.delete(character)
        saveContext()
        fetchFavorites()
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
