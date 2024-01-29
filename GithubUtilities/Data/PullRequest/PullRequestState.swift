//
//  PullRequestState.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 28/01/2024.
//

import Foundation

enum PullRequestState: String, Codable {
    case open
    case closed
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        switch value {
            case Self.open.rawValue: self = .open
            case Self.closed.rawValue: self = .closed
            default: self = .unknown
        }
    }
}
