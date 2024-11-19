//
//  Character.swift
//  RickAndMortyCharacters
//
//  Created by Анастасия Козлова on 19.11.2024.
//

import Foundation

struct Characters {
    let results: [Character]
}

struct Character {
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: URL
}

struct Origin {
    let name: String
}

struct Location {
    let name: String
}
