//
//  FavoriteButton.swift
//  CryptoWathcer
//
//  Created by Viktor Golovach on 10.09.2023.
//

import SwiftUI

struct FavoriteButton: View {
    
    @Binding var didChange: Bool
    
    var body: some View {
        Button {
            didChange.toggle()
        } label: {
            Label("Toggle Favorite",
                  systemImage: didChange
                  ? "star.fill"
                  : "star")
            .labelStyle(.iconOnly)
            .foregroundColor(
                didChange
                ? .yellow
                : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(didChange: .constant(true))
    }
}
