//
//  GithubUtilitiesApp.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 26/01/2024.
//

import SwiftUI

@main
struct GithubUtilitiesApp: App {
    private let notificationsModel = NotificationsModel(networkService: NetworkService())
    private let tokenModel = GithubTokenModel()

    var body: some Scene {
        WindowGroup {
            ContentView(model: notificationsModel, tokenModel: tokenModel)
        }
    }
}
