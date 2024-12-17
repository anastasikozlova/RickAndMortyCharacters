//
//  CharacterDetailsViewController.swift
//  RickAndMortyCharacters
//
//  Created by Анастасия Козлова on 06.12.2024.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    // MARK: - Public Properties
    var character: Character!
    
    // MARK: - Private Properties
    private var spinnerView = UIActivityIndicatorView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = character.name
        statusLabel.text = "Status: \(character.status)"
        speciesLabel.text = "Species: \(character.species)"
        genderLabel.text = "Gender: \(character.gender)"
        originLabel.text = "Origin: \(character.origin.name)"
        locationLabel.text = "Location: \(character.location.name)"
        
        showSpinner(in: characterImage)
        fetchImage()
        
        characterImage.layer.cornerRadius = characterImage.frame.width / 2
    }
    
    // MARK: - Private Methods
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .white
        spinnerView.startAnimating()
        spinnerView.center = view.center
        spinnerView.hidesWhenStopped = true
        view.addSubview(spinnerView)
    }
}
