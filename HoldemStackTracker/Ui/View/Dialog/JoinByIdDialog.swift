//
//  JoinByIdSheet.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/08/03.
//

import Foundation
import SwiftUI

struct JoinByIdDialog: View {
    @State var uiState: JoinByIdDialogUiState
    
    let onClickDone: () -> Void

    var body: some View {
        
        ZStack() {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                TextField("文字入力", text: $uiState.inputText)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)

                HStack() {
                    Spacer()
                    Button("完了") {
                        onClickDone()
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 10)
        }
    }
}

class JoinByIdDialogUiState: ObservableObject {
    @Published var inputText: String = ""
    
    init(inputText: String = "") {
        self.inputText = inputText
    }
}

#Preview {
    JoinByIdDialog(
        uiState: JoinByIdDialogUiState(inputText: "previewhoge"),
        onClickDone: {},
    )
}
