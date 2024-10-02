//
//  ContentView.swift
//  MarvelApp
//
//  Created by Alberto Orrantia on 01/10/24.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}

// Testing purposes only, EREASE after this commit and will maitain MVVM and clean architecture principles

struct ContentView: View {
    @State private var characters: [Character] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            if isLoading {
                // Spinner Load
                ProgressView("Loading characters...")
            } else if let errorMessage = errorMessage {
                // Show the error message if something goes wrong
                Text("Error: \(errorMessage)")
            } else {
                List(characters) { character in
                    HStack {
                        // Load character image using AsyncImage
                        AsyncImage(url: URL(string: character.thumbnailURL)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView() // Placeholder while image loads
                        }

                        // Display character name
                        Text(character.name)
                            .font(.headline)
                            .padding(.leading, 10)
                    }
                }
                .navigationTitle("Marvel Characters")
            }
        }
        .onAppear {
            loadCharacters()
        }
    }

    func loadCharacters() {
        let apiClient = MarvelAPIDataClient()
        apiClient.fetchCharacters { result in
            if let result = result {
                DispatchQueue.main.async {
                    self.characters = result
                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to load characters."
                    self.isLoading = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
