//
//  ElevatedCardView.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/05/06.
//

import Foundation
import SwiftUICore
import SwiftUI

struct ElevatedCardWithIconAndNameView: View {
    var imageResKey: String?
    var labelKey: LocalizedStringKey
    var onClick: (() -> Void) = {}
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            if let imageName: String = imageResKey {
                Image(imageName)
                    .imageScale(.large)
                    .foregroundStyle(.primary)
            }
            Text(labelKey)
                .font(.subheadline)
        }
        .padding()
        // FIXME: 本当は親で定義したいが・・・うまくいかないので、ここで定義している
        .frame(maxWidth: .infinity)
        .background()
        .cornerRadius(16)
        .clipped()
        .shadow(
            color: Color.gray.opacity(0.2),
            radius: 7
        )
        .onTapGesture {
            onClick()
        }
    }
}

#Preview {
    ElevatedCardWithIconAndNameView(
        imageResKey: "home",
        labelKey: "button_create_table"
    )
    .frame(maxWidth: .infinity)
}
