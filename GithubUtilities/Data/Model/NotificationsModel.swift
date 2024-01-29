//
//  NotificationsModel.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 27/01/2024.
//

import Combine
import OSLog
import SwiftUI

private let logger = Logger(subsystem: "GithubUtilities", category: "NotificationsModel")

@Observable class NotificationsModel {
    var notifications: [Notification] = []

    private var cancellable: AnyCancellable?

    private let networkService: NetworkService
    private let keychain: KeychainDataSource = .shared
    private let inMemory: Bool

    init(networkService: NetworkService, inMemory: Bool = false) {
        self.networkService = networkService
        self.inMemory = inMemory

        if inMemory {
            notifications = Notification.all
        }
    }

    func fetchNotificationsPeriodically() async {
        guard !inMemory else { return }

        Task {
            let notifications = await networkService.fetchNotifications()
            self.notifications = notifications
        }

        cancellable = Timer.publish(every: 10, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                logger.info("Fetching notifications")

                Task {
                    let notifications = await self.networkService.fetchNotifications()
                    self.notifications.update(with: notifications)
                    logger.info("Fetched notifications")
                }
            })
    }

    func dispose() {
        cancellable?.cancel()
    }
}
