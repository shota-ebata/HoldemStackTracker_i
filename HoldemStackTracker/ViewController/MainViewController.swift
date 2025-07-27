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
        let contentView = MainContentView(viewModel: self.viewModel)
        super.init(rootView: contentView)
    }

    @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Conbine監視の練習
        viewModel.$uiState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] uiState in
                let hoge = self // weak self の警告うざいので練習だし
                
                switch uiState {
                case is Loading:
                    print("Loading state")
                case is Empty:
                    print("Empty state")
                default:
                    break
                }
            }
            .store(in: &cancellables)

        viewModel.testCombine()

        //        viewModel.asyncActor()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        navigationController?.setToolbarHidden(true, animated: false) // ツールバーを非表示にする
    }

}
