//
//  KeychainDataSource.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 29/01/2024.
//

import KeychainSwift
import Foundation

struct KeychainDataSource {
    private enum Keys: String {
        case githubAPIToken
    }

    static let shared = KeychainDataSource()

    private let keychain = KeychainSwift()

    private init() {}

    func hasToken() -> Bool {
        return getToken() != nil
    }

    func setToken(_ token: String) -> Bool {
        return keychain.set(token, forKey: Keys.githubAPIToken.rawValue)
    }

    func getToken() -> String? {
        return keychain.get(Keys.githubAPIToken.rawValue)
    }
}
