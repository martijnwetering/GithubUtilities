//
//  NetworkService.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 26/01/2024.
//

import Foundation

enum GHUApiError: Error {
    case invalidResponse, invalidData
}

final class NetworkService {
    private let baseURL = "https://api.github.com"
    private let keychain: KeychainDataSource = .shared

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func fetchNotifications() async -> [Notification] {
        var url = URL(string: "\(baseURL)/notifications")!

        url.append(queryItems: [
            URLQueryItem(name: "all", value: "true"),
            URLQueryItem(name: "per_page", value: "25")
        ])

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(keychain.getToken()!)", forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("No valid response from the server.")
                return []
            }

            var notifications = try decoder.decode([Notification].self, from: data)

            let task = Task { [notifications] () -> [Notification] in
                var notificationsCopy = notifications

                await withTaskGroup(of: (Int, PullRequest?).self) { [weak self] group in
                    guard let self else { return }

                    for (index, notification) in notificationsCopy.enumerated() {
                        if let url = notification.subject.url {
                            group.addTask {
                                let pullRequest = try? await self.fetchPullRequest(for: url)
                                return (index, pullRequest)
                            }
                        }
                    }

                    for await (index, pullRequest) in group {
                        notificationsCopy[index].pullRequest = pullRequest
                    }
                }

                return notificationsCopy
            }

            notifications = await task.value

            return notifications

        } catch {
            print("Error: \(error.localizedDescription)")
            return []
        }
    }

    func fetchPullRequest(for url: String) async throws -> PullRequest {
        let url = URL(string: url)!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(keychain.getToken()!)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

        let pullRequest = try decoder.decode(PullRequest.self, from: data)
        return pullRequest
    }

}
