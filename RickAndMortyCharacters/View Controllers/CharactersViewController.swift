//
//  ViewController.swift
//  RickAndMortyCharacters
//
//  Created by Анастасия Козлова on 19.11.2024.
//

import UIKit

final class CharactersViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var characters: [Character] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
        tableView.rowHeight = 100
    }
    
    private func fetchCharacters() {
        networkManager.fetchCharacters(from: networkManager.url) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }


}

extension CharactersViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        guard let cell = cell as? CharacterCell else { return UITableViewCell()}
        let character = characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
}


