//
//  MainContentViewModel.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/06/24.
//

import Foundation
import Combine

@MainActor
final class MainViewModel {
    private let myReposiyory: MyRepositoryProtocol
    
    let uiState: MainScreenUiState
    let dialogUiState: MainContentDialogUiState
    
    let navigateEvent = PassthroughSubject<MainContentNavigateEvent, Never>()
    
    
    @Published var callA: Int = 10
    @Published var callB: Int = 20
    
    lazy var c = Publishers.CombineLatest($callA, $callB)
        .map { $0 + $1 }
        .eraseToAnyPublisher()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        myReposiyory: MyRepositoryProtocol = MyRepository()
    ) {
        self.myReposiyory = myReposiyory
        self.uiState = MainScreenUiState()
        self.dialogUiState = MainContentDialogUiState()
        
        uiState.shouldShowScreenLoading = false
        
        c.sink { value in
            print("合計: \(value)")
        }.store(in: &cancellables)
        
        callA = 30
    }
    
    
    func onClickAdd() {
        // TODO: shouldShowMainConsoleDialogをtrueにする
    }
    
    func onClickTableCreator() {
        
    }
    
    func onClickJoinTableByQr() {
        
    }
    
    func onClickJoinTableById() {
        dialogUiState.joinByIdSheetUiState = JoinByIdContentUiState()
    }
    
    func onClickJoinedCard() {
        print("onClickJoinedTable")
    }
    
    func onDissmissRequestJoinByIdDialog() {
        dialogUiState.joinByIdSheetUiState = nil
    }
    
    func onClickJoinByIdDialogDone() {
        guard let joinByIdDialogInputText: String = dialogUiState.joinByIdSheetUiState?.inputText else {
            return
        }
        // TODO: id使って検索してねー
        print(joinByIdDialogInputText)
        onDissmissRequestJoinByIdDialog()
    }
}

@MainActor
class MainContentDialogUiState : ObservableObject {
    @Published var joinByIdSheetUiState: JoinByIdContentUiState? = nil
}

enum MainContentNavigateEvent {
    case TableCreator
    case TablePrepare
    case Game
    case CloseApp
}


