//
//  GHUser.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 28/01/2024.
//

import Foundation

struct GHUser: Codable, Identifiable {
    let id: Int
    let login: String
    let avatarUrl: String
}

extension GHUser {
    static let preview = GHUser(id: 1, login: "octocat", avatarUrl: "")
}
