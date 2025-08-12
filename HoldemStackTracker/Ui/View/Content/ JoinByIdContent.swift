//
//   JoinByIdContent.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/08/12.
//

import SwiftUI

struct JoinByIdContent: View {
    @ObservedObject var uiState: JoinByIdContentUiState
    let onClickDone: () -> Void
    let onClickCancel: () -> Void
    
    var body: some View {
        VStack {
            HStack() {
                Button("button_cancel") {
                    onClickCancel()
                }
                .padding(16)
                
                Spacer()
                Button("button_search") {
                    onClickDone()
                }
                .padding(16)
            }
            TextField("label_table_id", text: $uiState.inputText)
                .padding()
                .textFieldStyle(
                    RoundedBorderTextFieldStyle()
                )
                .background(Color.white)
                .cornerRadius(8)
        }
            
    }
}

class JoinByIdContentUiState: ObservableObject {
    @Published var inputText: String = ""
}

#Preview {
    JoinByIdContent(
        uiState: JoinByIdContentUiState(),
        onClickDone: {},
        onClickCancel: {},
    )
}
