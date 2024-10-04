//
//  Character.swift
//  MarvelApp
//
//  Created by Alberto Orrantia on 02/10/24.
//

import Foundation

struct MarvelResponse: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let results: [Character]
    let total: Int
}

struct Character: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail

    var thumbnailURL: String {
        return thumbnail.path.hasPrefix("http://") ? thumbnail.path.replacingOccurrences(of: "http://", with: "https://") + ".\(thumbnail.extension)" : "\(thumbnail.path).\(thumbnail.extension)"
    }
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
}

