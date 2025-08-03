//
//  JoinByIdSheet.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/08/03.
//

import Foundation
import SwiftUI

struct JoinByIdSheet: View {
    @State var inputText: String
    
    let onClickDone: () -> Void

    var body: some View {
        
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                TextField("文字入力", text: $inputText)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)

                Button("完了") {
                    onClickDone()
                    // 入力処理
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 10)
        }
    }
}

#Preview {
    JoinByIdSheet(
        inputText: "previewhoge",
        onClickDone: {},
    )
}
