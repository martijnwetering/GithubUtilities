//
//  PullRequest.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 28/01/2024.
//

import Foundation

struct PullRequest: Codable, Identifiable {
    let id: Int
    let title: String
    let state: PullRequestState
    let user: GHUser
    let number: Int
}

extension PullRequest {
    static let openPRPReview = PullRequest(id: 1, title: "Fix styling for home screen", state: .open, user: GHUser.preview, number: 3244)
    static let closedPRPreview = PullRequest(id: 1, title: "Fix styling for home screen", state: .closed, user: GHUser.preview, number: 9824)
}
