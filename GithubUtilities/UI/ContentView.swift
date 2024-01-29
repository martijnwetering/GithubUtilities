//
//  ContentView.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 26/01/2024.
//

import Combine
import SwiftUI

struct ContentView: View {
    let model: NotificationsModel
    let tokenModel: GithubTokenModel

    var body: some View {
        NavigationStack {
            if tokenModel.tokenStatus == .unavailable {
                GithubTokenView(model: tokenModel)
            } else if tokenModel.tokenStatus == .available {
                NotificationsView(model: model)
            } else {
                ProgressView()
            }
        }
        .onAppear { tokenModel.checkGithubToken() }
    }
}

#Preview {
    let model = NotificationsModel(networkService: NetworkService(), inMemory: true)
    let tokenModel = GithubTokenModel()
    return ContentView(model: model, tokenModel: tokenModel)
}

