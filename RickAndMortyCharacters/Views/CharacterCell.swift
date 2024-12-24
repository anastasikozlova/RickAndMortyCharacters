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
        characterImage.contentMode = .scaleAspectFit
        characterImage.clipsToBounds = true
        characterImage.layer.cornerRadius = characterImage.frame.height / 2
        
        guard let url = URL(string: character.image) else { return }
        NetworkManager.shared.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
