//
//  Notification.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 26/01/2024.
//

import Foundation

struct Notification: Codable, Identifiable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id, unread, reason, updatedAt, lastReadAt, subject, repository
    }

    let id: String
    let unread: Bool
    let reason: String
    let updatedAt: Date
    let lastReadAt: Date?
    let subject: Subject
    let repository: Repository
    var pullRequest: PullRequest?

    static func == (lhs: Notification, rhs: Notification) -> Bool {
        lhs.id == rhs.id
    }
}

extension Notification {
    static let preview = Notification(
        id: "Notification#\(1201)",
        unread: true,
        reason: "review_requested",
        updatedAt: Date(),
        lastReadAt: Date(),
        subject: Subject.preview,
        repository: Repository.preview,
        pullRequest: PullRequest.openPRPReview
    )

    static let preview2 = Notification(
        id: "Notification#\(1202)",
        unread: true,
        reason: "review_requested",
        updatedAt: Date(),
        lastReadAt: Date(),
        subject: Subject.preview2,
        repository: Repository.preview2,
        pullRequest: PullRequest.closedPRPreview
    )

    static let preview3 = Notification(
        id: "Notification#\(1203)",
        unread: false,
        reason: "review_requested",
        updatedAt: Date(),
        lastReadAt: Date(),
        subject: Subject.preview3,
        repository: Repository.preview3,
        pullRequest: PullRequest.closedPRPreview
    )

    static let all = [preview, preview2, preview3]
}
