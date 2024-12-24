//
//  Character.swift
//  RickAndMortyCharacters
//
//  Created by Анастасия Козлова on 19.11.2024.
//

import Foundation

struct RickAndMorty: Decodable {
    let info: Info
    let results: [Character]
    
    init(rickAndMortyData: [String: Any]) {
        // Parse `info`
        info = Info(infoData: rickAndMortyData["info"] as? [String: Any] ?? [:])
        
        // Parse `results` as an array of dictionaries and map each dictionary to a `Character`
        if let resultsArray = rickAndMortyData["results"] as? [[String: Any]] {
            results = resultsArray.map { Character(characterData: $0) }
        } else {
            results = [] // Default to an empty array if `results` key is missing or invalid
        }
    }
    
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
    
    init(infoData: [String: Any]) {
        pages = infoData["pages"] as? Int ?? 0
        next = infoData["next"] as? String ?? ""
        prev = infoData["prev"] as? String ?? ""
    }
}
struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Origin
    let image: String
    
    init(characterData: [String: Any]) {
        name = characterData["name"] as? String ?? ""
        status = characterData["status"] as? String ?? ""
        species = characterData["species"] as? String ?? ""
        gender = characterData["gender"] as? String ?? ""
        origin = Origin(originData: characterData["origin"] as? [String: Any] ?? [:])
        location = Origin(originData: characterData["location"] as? [String: Any] ?? [:])
        image = characterData["image"] as? String ?? ""
    }
}

struct Origin: Decodable {
    let name: String
    
    init(originData: [String: Any]) {
        name = originData["name"] as? String ?? ""
    }
}
