//
//  CharacterWorker.swift
//  RMYapDatabaseCleanSwift
//
//  Created by Ибрагим Габибли on 13.02.2025.
//

import Foundation
import UIKit

final class CharacterWorker: CharacterWorkerProtocol {
    var networkManager: NetworkManagerProtocol
    var storageManager: StorageManagerProtocol

    init(networkManager: NetworkManagerProtocol,
         storageManager: StorageManagerProtocol
    ) {
        self.networkManager = networkManager
        self.storageManager = storageManager
    }

    func getCharacters(completion: @escaping ([Character]) -> Void) {
        let savedCharacters = storageManager.loadCharacters()

        if !savedCharacters.isEmpty {
            completion(savedCharacters)
        } else {
            networkManager.getCharacters { [weak self] result in
                switch result {
                case .success(let characters):
                    completion(characters)
                    characters.forEach { character in
                        self?.storageManager.saveCharacter(character, key: "\(character.id)")
                    }
                case .failure(let error):
                    print("Error fetching characters: \(error)")
                    completion([])
                }
            }
        }
    }

    func loadImage(for character: Character, completion: @escaping (UIImage?) -> Void) {
        networkManager.loadImage(from: character.image, completion: completion)
    }
}
