//
//  CharacterCell.swift
//  RickAndMortyCharacters
//
//  Created by Анастасия Козлова on 21.11.2024.
//

import Foundation
import UIKit

final class CharacterCell: UITableViewCell {
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var characterName: UILabel!
    
    func configure(with character: Character) {
        characterName.text = "Name: \(character.name)"
        
        NetworkManager.shared.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
