//
//  Repository.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 27/01/2024.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
}

extension Repository {
    static let preview = Repository(id: 1, name: "ecommerce-freya-app")
    static let preview2 = Repository(id: 1, name: "ios-appie")
    static let preview3 = Repository(id: 1, name: "android-appie")
    static let all = [preview, preview2, preview3]
}
