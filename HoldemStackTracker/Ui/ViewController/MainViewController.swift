//
//  MainViewController.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/06/17.
//

import Combine
import SwiftUI

class MainViewController: UIHostingController<MainContentView> {

    private let viewModel = MainContentViewModel()

    private var cancellables = Set<AnyCancellable>()

    init() {
        let contentView = MainContentView(
            uiState: viewModel.uiState,
            dialogUiState: viewModel.dialogUiState,
            onClickSearchById: viewModel.onClickSearchById,
            onClickJoinByIdDialogDone: viewModel.onClickJoinByIdDialogDone,
            onDissmissRequestJoinByIdDialog: viewModel.onDissmissRequestJoinByIdDialog
        )
        super.init(rootView: contentView)
    }

    @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        observeNavigateEvent()
        //        viewModel.asyncActor()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        navigationController?.setToolbarHidden(true, animated: false) // ツールバーを非表示にする
    }
    
    private func observeNavigateEvent() {
        viewModel.navigateEvent
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] event in
                print("Navigate event received: \(event)")
            }
            .store(in: &cancellables)
    }
}
