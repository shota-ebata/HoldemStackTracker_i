//
//  ContentView.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/03/16.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        VStack(
            spacing: 16,
        ) {
            VStack(
                alignment: .leading
            ) {
                Text("button_create_table")
                    .padding(.bottom, 8)
                    .font(.title)
                ElevatedCardWithIconAndNameView(
                    imageResKey: "home",
                    labelKey: "label_create_table",
                    onClick: {
                        print("onClick home")
                    }
                )
            }
            .padding(.horizontal, 8)
            
            VStack(
                alignment: .leading
            ) {
                Text("label_join_table")
                    .padding(.bottom, 8)
                    .font(.title)
                HStack(spacing: 8) {
                    ElevatedCardWithIconAndNameView(
                        imageResKey: "qr_code_scanner",
                        labelKey: "button_qr_scanner",
                        onClick: {
                            print("onClick QR scanner")
                        }
                    )
                    ElevatedCardWithIconAndNameView(
                        imageResKey: "edit",
                        labelKey: "button_table_id_search",
                        onClick: {
                            print("onClick Search table ID")
                        }
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 8)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .padding(.horizontal, 8)
    
    }
}

#Preview {
    MainContentView()
}
