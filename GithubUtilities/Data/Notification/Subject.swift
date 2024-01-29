//
//  Subject.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 27/01/2024.
//

import Foundation

struct Subject: Codable {
    let title: String
    let url: String?
    let type: String
}

extension Subject {
    static let preview = Subject(title: "Add list to orders overview", url: "https://test.nl", type: "PullRequest")
    static let preview2 = Subject(title: "Fixed tests", url: "https://test.nl", type: "PullRequest")
    static let preview3 = Subject(title: "Add secrets to keychain", url: "https://test.nl", type: "PullRequest")
}
