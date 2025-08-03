//
//  ContentView.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/03/16.
//

import SwiftUI

struct MainContentView: View {

    @StateObject var uiState: MainContentUiState
    @StateObject var dialogUiState: MainContentDialogUiState
    
    let onClickSearchById: () -> Void
    let onClickJoinByIdDialogDone: () -> Void
    let onDissmissRequestJoinByIdDialog: () -> Void
    
    init(
        uiState: MainContentUiState,
        dialogUiState: MainContentDialogUiState,
        onClickSearchById: @escaping () -> Void,
        onClickJoinByIdDialogDone: @escaping () -> Void,
        onDissmissRequestJoinByIdDialog: @escaping () -> Void,
    ) {
        self._uiState = StateObject(wrappedValue: uiState)
        self._dialogUiState = StateObject(wrappedValue: dialogUiState)
        self.onClickSearchById = onClickSearchById
        self.onClickJoinByIdDialogDone = onClickJoinByIdDialogDone
        self.onDissmissRequestJoinByIdDialog = onDissmissRequestJoinByIdDialog
    }

    var body: some View {
        ZStack {
            VStack(
                spacing: 16,
            ) {
                if uiState.shouldShowScreenLoading {
                    LoadingContent()
                } else {
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
                                    onClickSearchById()
                                }
                            )
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 8)
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
            
            // Dialog
            if let joinByIdDialogUiState = dialogUiState.joinByIdDialogUiState {
                JoinByIdDialog(
                    uiState: joinByIdDialogUiState,
                    onClickDone: onClickJoinByIdDialogDone
                )
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
    MainContentView(
        uiState: MainContentUiState(shouldShowScreenLoading: false),
        dialogUiState: MainContentDialogUiState(),
        onClickSearchById: {},
        onClickJoinByIdDialogDone: {},
        onDissmissRequestJoinByIdDialog: {},
    )
}
