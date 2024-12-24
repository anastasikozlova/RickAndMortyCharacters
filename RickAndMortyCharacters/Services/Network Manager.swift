//
//  Network Manager.swift
//  RickAndMortyCharacters
//
//  Created by Анастасия Козлова on 20.11.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    let url = "https://rickandmortyapi.com/api/character"
    
    private init() {}
    
    func fetchData(from url: URL?, completion: @escaping(Result<RickAndMorty, AFError>) -> Void) {
        guard let url = url else {
            completion(.failure(AFError.parameterEncodingFailed(reason: .missingURL)))
            return
        }
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let jsonValue):
                    guard let data = jsonValue as? [String: Any] else { return}
                    let rickData = RickAndMorty(rickAndMortyData: data)
                    completion(.success(rickData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
 
    func fetchImage(from url: URL, completion: @escaping (Result<Data, AFError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
