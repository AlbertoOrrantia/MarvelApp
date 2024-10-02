//
//  MarvelAPIDataClient.swift
//  MarvelApp
//
//  Created by Alberto Orrantia on 01/10/24.
//

import Foundation
import CryptoKit

// Helper Function to get API keys from Secrets.plist file
func getAPIKey(named keyName: String) -> String {
    guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
          let xml = FileManager.default.contents(atPath: path),
          let plist = try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainers, format: nil) as? [String: Any] else {
        return ""
    }
    return plist[keyName] as? String ?? ""
}

class MarvelAPIDataClient {
    private let publicKey = getAPIKey(named: "MARVEL_PUBLIC_KEY")
    private let privateKey = getAPIKey(named: "MARVEL_PRIVATE_KEY")
    
    func fetchCharacters(completion: @escaping ([Character]?) -> Void) {
        let ts = "\(Int(Date().timeIntervalSince1970))"
        let hash = generateMarvelHash(ts: ts, privateKey: privateKey, publicKey: publicKey)

        let urlString = "https://gateway.marvel.com/v1/public/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let marvelData = try decoder.decode(MarvelResponse.self, from: data)
                completion(marvelData.data.results)
            } catch {
                completion(nil)
            }
        }.resume()
    }

    private func generateMarvelHash(ts: String, privateKey: String, publicKey: String) -> String {
        let hashString = ts + privateKey + publicKey
        let hash = Insecure.MD5.hash(data: Data(hashString.utf8))
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}
// To maintain MVVM and Clean Architecture principles, this should NOT be here. However for this commit and for first testing purposes I will leave this here

struct MarvelResponse: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let results: [Character]
}

struct Character: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail

    var thumbnailURL: String {
        //return "\(thumbnail.path).\(thumbnail.extension)"
        return thumbnail.path.hasPrefix("http://") ? thumbnail.path.replacingOccurrences(of: "http://", with: "https://") + ".\(thumbnail.extension)" : "\(thumbnail.path).\(thumbnail.extension)"
    }
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
}
