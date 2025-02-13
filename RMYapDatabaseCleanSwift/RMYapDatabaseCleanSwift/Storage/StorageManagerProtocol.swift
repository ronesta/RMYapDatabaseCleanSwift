//
//  StorageManagerProtocol.swift
//  RMYapDatabaseCleanSwift
//
//  Created by Ибрагим Габибли on 13.02.2025.
//

import Foundation

protocol StorageManagerProtocol {
    func saveCharacter(_ character: Character, key: String)

    func saveCharacters(_ characters: [Character])

    func loadCharacter(key: String) -> Character?

    func loadCharacters() -> [Character]

    func clearCharacters()

    func saveImage(_ image: Data, key: String)

    func loadImage(key: String) -> Data?

    func clearImage(key: String)
}
