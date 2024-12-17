//
//  Character.swift
//  RickAndMortyCharacters
//
//  Created by Анастасия Козлова on 19.11.2024.
//

import Foundation

struct Characters: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Origin
    let image: URL
}

struct Origin: Decodable {
    let name: String
}
