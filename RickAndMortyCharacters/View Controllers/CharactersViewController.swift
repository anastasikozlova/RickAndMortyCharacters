//
//  ViewController.swift
//  RickAndMortyCharacters
//
//  Created by Анастасия Козлова on 19.11.2024.
//

import UIKit

final class CharactersViewController: UITableViewController {
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    private var characters: [Character] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        
        fetchCharacters()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let characterDetailsVC = segue.destination as? CharacterDetailsViewController
        characterDetailsVC?.character = characters[indexPath.row]
    }
    
    // MARK: - Private Methods
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

// MARK: - UITableViewDataSource
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


