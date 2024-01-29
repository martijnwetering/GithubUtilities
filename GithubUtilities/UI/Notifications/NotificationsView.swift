//
//  NotificationsView.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 29/01/2024.
//

import SwiftUI

struct NotificationsView: View {
    @Bindable var model: NotificationsModel

    var body: some View {
        ZStack {
            Color.backgroundSecondary

            if !model.notifications.isEmpty {
                VStack {
                    List(model.notifications) { notification in
                        HStack {
                            if notification.unread {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 8)
                                    .padding(.trailing, 4)
                            } else {
                                Spacer()
                                    .frame(width: 8)
                                    .padding(.trailing, 4)
                            }

                            if let pullRequest = notification.pullRequest {
                                switch pullRequest.state {
                                    case .open:
                                        Image(.pullRequestOpen)
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .padding(.horizontal, 2)
                                    case .closed:
                                        Image(.pullRequestMerged)
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .padding(.horizontal, 2)
                                    default:
                                        Spacer()
                                            .frame(width: 15)
                                            .padding(.horizontal, 2)
                                }
                            } else {
                                Spacer()
                                    .frame(width: 15)
                                    .padding(.horizontal, 2)
                            }

                            VStack(alignment: .leading) {
                                HStack {
                                    Text(notification.repository.name)
                                        .font(.system(size: 12))
                                    .foregroundStyle(.foregroundPrimary)

                                    if let number = notification.pullRequest?.number {
                                        Text("#\(String(number))")
                                            .font(.system(size: 12))
                                            .foregroundStyle(.foregroundSecondary)
                                    }
                                }

                                Text(notification.subject.title)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.foregroundPrimary)
                            }

                            Spacer()

                            HStack(spacing: 24) {
                                Text(notification.reason)
                                    .font(.system(size: 12))
                                    .foregroundStyle(.foregroundPrimary)

                                AsyncImage(url: URL(string: notification.pullRequest?.user.avatarUrl ?? "")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                        .frame(height: 20)
                                } placeholder: {
                                    AvatarPlaceholderView()
                                }

                                Text(notification.updatedAt.toTimeSince())
                                    .font(.system(size: 12))
                                    .foregroundStyle(.foregroundPrimary)
                                    .frame(width: 100)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .scrollContentBackground(.hidden)
                }
            } else {
                ContentUnavailableView("No notifications", systemImage: "info")
            }
        }
        .task { Task { await model.fetchNotificationsPeriodically() } }
        .onDisappear { model.dispose() }
    }
}

#Preview {
    let model = NotificationsModel(networkService: NetworkService(), inMemory: true)
    return NotificationsView(model: model)
}
