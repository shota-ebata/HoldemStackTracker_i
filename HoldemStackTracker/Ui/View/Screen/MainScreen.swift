//
//  ContentView.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/03/16.
//

import SwiftUI

struct MainScreen: View {

    @StateObject var uiState: MainContentUiState
    @StateObject var dialogUiState: MainContentDialogUiState

    let onClickTableCreator: () -> Void
    let onClickJoinTableByQr: () -> Void
    let onClickJoinTableById: () -> Void
    let onClickJoinByIdDialogDone: () -> Void
    let onDissmissRequestJoinByIdDialog: () -> Void

    init(
        uiState: MainContentUiState,
        dialogUiState: MainContentDialogUiState,
        onClickTableCreator: @escaping () -> Void,
        onClickJoinTableByQr: @escaping () -> Void,
        onClickJoinTableById: @escaping () -> Void,
        onClickJoinByIdDialogDone: @escaping () -> Void,
        onDissmissRequestJoinByIdDialog: @escaping () -> Void,
    ) {
        self._uiState = StateObject(wrappedValue: uiState)
        self._dialogUiState = StateObject(wrappedValue: dialogUiState)
        self.onClickTableCreator = onClickTableCreator
        self.onClickJoinTableByQr = onClickJoinTableByQr
        self.onClickJoinTableById = onClickJoinTableById
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
        ZStack {
            VStack(
                spacing: 16,
            ) {
                if uiState.shouldShowScreenLoading {
                    LoadingContent()
                } else {
                    TableMainConsoleContent(
                        onClickTableCreator: {},
                        onClickJoinTableByQr: onClickJoinTableByQr,
                        onClickJoinTableById: onClickJoinTableById,
                    )
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .top
            )
            .padding(.horizontal, 8)
            //        .navigationBarBackButtonHidden(true)
            //        .navigationBarHidden(true)

        }
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

final class MainContentUiState: ObservableObject {
    @Published var shouldShowScreenLoading: Bool = true
    @Published var isEmpty: Bool = false

    init(
        shouldShowScreenLoading: Bool = true,
        isEmpty: Bool = false,
    ) {
        self.shouldShowScreenLoading = shouldShowScreenLoading
        self.isEmpty = isEmpty
    }
}

#Preview {
    MainScreen(
        uiState: MainContentUiState(shouldShowScreenLoading: false),
        dialogUiState: MainContentDialogUiState(),
        onClickTableCreator: {},
        onClickJoinTableByQr: {},
        onClickJoinTableById: {},
        onClickJoinByIdDialogDone: {},
        onDissmissRequestJoinByIdDialog: {},
    )
}
