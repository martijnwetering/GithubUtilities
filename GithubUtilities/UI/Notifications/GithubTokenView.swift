//
//  GithubTokenView.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 29/01/2024.
//

import SwiftUI

struct GithubTokenView: View {
    @Bindable var model: GithubTokenModel

    @State var token: String = ""

    var body: some View {
        TextField("GitHub API token", text: $token)
            .textFieldStyle(.roundedBorder)
            .onSubmit() {
                if !token.isEmpty {
                    model.setToken(token)
                }
            }
    }
}

#Preview {
    let tokenModel = GithubTokenModel()
    return GithubTokenView(model: tokenModel)
}
