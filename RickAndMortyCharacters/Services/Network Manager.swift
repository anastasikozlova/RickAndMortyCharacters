//
//  Network Manager.swift
//  RickAndMortyCharacters
//
//  Created by Анастасия Козлова on 20.11.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    let url = URL(string: "https://rickandmortyapi.com/api/character")!
    
    private init() {}
    
    func fetchCharacters(from url: URL, completion: @escaping (Result<[Character], NetworkError>) ->
       Void) {
           URLSession.shared.dataTask(with: url) { data, _, error in
               guard let data else {
                   completion(.failure(.noData))
                   print(error?.localizedDescription ?? "No error description")
                   return
               }
               
               do {
                   let characters = try JSONDecoder().decode(Characters.self, from: data)
                   
                   DispatchQueue.main.async {
                       completion(.success(characters.results))
                   }
               } catch {
                   completion(.failure(.decodingError))
               }
           }.resume()
        
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
