//
//  GithubTokenModel.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 29/01/2024.
//

import Foundation
import SwiftUI

enum GithubTokenStatus {
    case unknown, available, unavailable
}


@Observable class GithubTokenModel {
    private let keychain: KeychainDataSource = .shared

    var tokenStatus: GithubTokenStatus = .unknown

    func checkGithubToken() {
        tokenStatus = keychain.hasToken() ? .available : .unavailable
    }

    func setToken(_ token: String) {
        let hasToken = keychain.setToken(token)
        tokenStatus = hasToken ? .available : .unavailable
    }
}
