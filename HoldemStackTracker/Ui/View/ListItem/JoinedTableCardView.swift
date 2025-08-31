//
//  TableSummaryCardRow.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/08/12.
//

import SwiftUI

struct JoinedTableCardView: View {
    @StateObject var uiState: JoinedTableCardViewUiState
    
    let onClick: () -> Void

    init(
        uiState: JoinedTableCardViewUiState,
        onClick: @escaping () -> Void = {},
    ) {
        self._uiState = StateObject(wrappedValue: uiState)
        self.onClick = onClick
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(uiState.gameTypeText)
                    .font(.callout)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(
                        // TODO: 色を変更したい
                        Color.blue.opacity(0.1)
                    )
                    .cornerRadius(8)
                    .clipped()
                HStack(
                    spacing: 0,
                ) {
                    Text("label_blind")
                        .font(.callout)
                        .padding(.vertical, 2)
                        .padding(.leading, 8)
                        .padding(.trailing, 4)
                        .background(
                            // TODO: 色を変更したい
                            Color.blue.opacity(0.1)
                        )
                        .clipShape(
                            .rect(
                                topLeadingRadius: 8,
                                bottomLeadingRadius: 8,
                            )
                        )
                    Text(uiState.blindText)
                        .font(.callout)
                        .padding(.vertical, 2)
                        .padding(.leading, 4)
                        .padding(.trailing, 8)
                        .background(
                            Color.gray.opacity(0.1)
                        )
                        .clipShape(
                            .rect(
                                bottomTrailingRadius: 8,
                                topTrailingRadius: 8,
                            )
                        )
                }

            }
            HStack(
                spacing: 0,
            ) {
                Text("label_host")
                    .font(.body)
                Text(uiState.hostName)
                    .font(.body)
            }
            HStack(
                spacing: 0,
            ) {
                Spacer()
                Image("person")
                    .imageScale(.large)
                    .foregroundStyle(.primary)
                Text(uiState.playerSize)
                    .font(.body)
            }
            HStack(
                spacing: 0,
            ) {
                Spacer()
                Text("label_updated")
                    .font(.body)
                Text(uiState.updateTime)
                    .font(.body)
            }
        }
        .padding()
        // FIXME: 本当は親で定義したいが・・・うまくいかないので、ここで定義している
//        .frame(maxWidth: .infinity)
        .background(
            Color.blue.opacity(0.1)
        )
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

class JoinedTableCardViewUiState: ObservableObject, Identifiable {
    var id: String
    @Published var tableId: TableId
    @Published var gameTypeText: String
    @Published var blindText: String
    @Published var hostName: String
    @Published var playerSize: String
    @Published var updateTime: String
    @Published var createTime: String

    init(
        tableId: TableId,
        gameTypeText: String,
        blindText: String,
        hostName: String,
        playerSize: String,
        updateTime: String,
        createTime: String
    ) {
        self.id = tableId.value
        self.tableId = tableId
        self.gameTypeText = gameTypeText
        self.blindText = blindText
        self.hostName = hostName
        self.playerSize = playerSize
        self.updateTime = updateTime
        self.createTime = createTime
    }
}

#Preview {
    JoinedTableCardView(
        uiState: JoinedTableCardViewUiState(
            tableId: TableId(value: "test-table-id"),
            gameTypeText: "Ring Game",
            blindText: "100/200",
            hostName: "HostPlayer",
            playerSize: "5/10",
            updateTime: "2024/12/08 22:54:01",
            createTime: "2024/12/08 22:54:01",
        ),
        onClick: {},
    )
}
