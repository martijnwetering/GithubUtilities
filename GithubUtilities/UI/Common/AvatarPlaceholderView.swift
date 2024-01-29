//
//  PlaceholderView.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 29/01/2024.
//

import SwiftUI

struct AvatarPlaceholderView: View {
    var body: some View {
        Image(.githubOutline)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(Color.black)
            .frame(height: 20)
            .clipShape(Circle())
    }
}

#Preview {
    AvatarPlaceholderView()
}
