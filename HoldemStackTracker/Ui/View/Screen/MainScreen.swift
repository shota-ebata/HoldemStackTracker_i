//
//  ContentView.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/03/16.
//

import SwiftUI

struct MainScreen: View {

    @StateObject var uiState: MainScreenUiState
    @StateObject var dialogUiState: MainContentDialogUiState

    let onClickTableCreator: () -> Void
    let onClickJoinTableByQr: () -> Void
    let onClickJoinTableById: () -> Void
    let onClickJoinedCard: () -> Void
    let onClickJoinByIdDialogDone: () -> Void
    let onDissmissRequestJoinByIdDialog: () -> Void

    init(
        uiState: MainScreenUiState,
        dialogUiState: MainContentDialogUiState,
        onClickTableCreator: @escaping () -> Void,
        onClickJoinTableByQr: @escaping () -> Void,
        onClickJoinTableById: @escaping () -> Void,
        onClickJoinedCard: @escaping () -> Void,
        onClickJoinByIdDialogDone: @escaping () -> Void,
        onDissmissRequestJoinByIdDialog: @escaping () -> Void,
    ) {
        self._uiState = StateObject(wrappedValue: uiState)
        self._dialogUiState = StateObject(wrappedValue: dialogUiState)
        self.onClickTableCreator = onClickTableCreator
        self.onClickJoinTableByQr = onClickJoinTableByQr
        self.onClickJoinTableById = onClickJoinTableById
        self.onClickJoinedCard = onClickJoinedCard
        self.onClickJoinByIdDialogDone = onClickJoinByIdDialogDone
        self.onDissmissRequestJoinByIdDialog = onDissmissRequestJoinByIdDialog
    }

    var body: some View {
        // FIXME: Binding<X> → Binding<Y>の変換、もっとよい方法が無いか？
        let shouldShowJoinByIdSheet: Binding<Bool> = Binding(
            get: { dialogUiState.joinByIdSheetUiState != nil },
            set: { newValue in
                if !newValue {
                    onDissmissRequestJoinByIdDialog()
                }
            }
        )
        VStack(
            spacing: 16,
        ) {
            if uiState.shouldShowScreenLoading {
                LoadingContent()
            } else {
                TableMainConsoleContent(
                    onClickTableCreator: onClickTableCreator,
                    onClickJoinTableByQr: onClickJoinTableByQr,
                    onClickJoinTableById: onClickJoinTableById,
                )
                .padding(.horizontal, 8)

                if uiState.tableSummaryCardRowUiState != nil {
                    HStack {
                        Image("person_pin")
                            .imageScale(.large)
                            .foregroundStyle(.primary)
                        Text("label_joined")
                            .font(.body)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    JoinedTableCardView(
                        uiState: uiState.tableSummaryCardRowUiState!,
                        onClick: onClickJoinedCard
                    )
                    .padding(.horizontal, 16)
                }

            }
        }
        .navigationTitle("a")
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .sheet(
            isPresented: shouldShowJoinByIdSheet
        ) {
            if let joinByIdSheetUiState = dialogUiState.joinByIdSheetUiState {
                VStack {
                    JoinByIdContent(
                        uiState: joinByIdSheetUiState,
                        onClickDone: {
                            onClickJoinByIdDialogDone()
                        },
                        onClickCancel: {
                            onDissmissRequestJoinByIdDialog()
                        }
                    )
                }
                .padding(.horizontal, 16)
                .presentationDetents([.height(150)])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

@MainActor
final class MainScreenUiState: ObservableObject {
    @Published var shouldShowScreenLoading: Bool
    @Published var tableSummaryCardRowUiState: JoinedTableCardViewUiState? =
        JoinedTableCardViewUiState(
            tableId: TableId(value: "test-table-id"),
            gameTypeText: "Ring Game",
            blindText: "100/200",
            hostName: "HostPlayer",
            playerSize: "5/10",
            updateTime: "2024/12/08 22:54:01",
            createTime: "2024/12/08 22:54:01",
        )

    init(
        shouldShowScreenLoading: Bool = true,
    ) {
        self.shouldShowScreenLoading = shouldShowScreenLoading
    }
}

#Preview {
    MainScreen(
        uiState: MainScreenUiState(shouldShowScreenLoading: false),
        dialogUiState: MainContentDialogUiState(),
        onClickTableCreator: {},
        onClickJoinTableByQr: {},
        onClickJoinTableById: {},
        onClickJoinedCard: {},
        onClickJoinByIdDialogDone: {},
        onDissmissRequestJoinByIdDialog: {},
    )
}
