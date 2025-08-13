//
//  MainContent.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/08/12.
//

import SwiftUI

struct TableMainConsoleContent: View {
    
    let onClickTableCreator: () -> Void
    let onClickJoinTableByQr: () -> Void
    let onClickJoinTableById: () -> Void
    
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
                        onClickTableCreator()
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
                            onClickJoinTableByQr()
                        }
                    )
                    ElevatedCardWithIconAndNameView(
                        imageResKey: "edit",
                        labelKey: "button_table_id_search",
                        onClick: {
                            onClickJoinTableById()
                        }
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    TableMainConsoleContent(
        onClickTableCreator: {},
        onClickJoinTableByQr: {},
        onClickJoinTableById: {},
    )
}
