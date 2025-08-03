//
//  MainContentViewModel.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/06/24.
//

import Foundation
import Combine


class MainContentViewModel : ObservableObject {
    
    @Published var uiState: MainContentUiState = Loading.object
    
    
    @Published var callA: Int = 10
    @Published var callB: Int = 20
    
    lazy var c = Publishers.CombineLatest($callA, $callB)
        .map { $0 + $1 }
        .eraseToAnyPublisher()
    
    // Combineのキャンセラブルを保持するためのセット
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        c.sink { value in
            let emptyUiState = Empty()
            emptyUiState.title = "合計: \(value)"
            self.uiState = emptyUiState
        }.store(in: &cancellables)
    }
    
    func testCombine() {
        callA = 30
    }
    
    func async() {
        
        let bank = BankClass()
        DispatchQueue.global(qos: .default).async {
            print("call add loop")
            for _ in 0..<100 {
                bank.add(100)
            }
        }
        DispatchQueue.global(qos: .default).async {
            print("call remove loop")
            for _ in 0..<100 {
                bank.remove(100)
            }
        }
        
        Task {
            try await Task.sleep(for: .seconds(1))
            print(bank.currentSum)
        }
    }
    
    func asyncActor() {
        let bank = ABankClass(name: "A-Bank")
//        print(bank.name)
        print(bank.bankName)
        Task {
            for _ in 0..<100 {
                await bank.add(100)
                await bank.remove(100)
            }
            print("process1 ended")
        }
        Task {
            try await Task.sleep(for: .seconds(1))
            print(await bank.currentSum)
            print("process1 ended")
        }
        
    }
    
    func onClickCreateTableButton() {
        
    }
    
    func onClickQrButtonButton() {
        
    }
    
    func onClickSearchById() {
        
    }
    
    
}

actor ABankClass {

    private var current = 0
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func add(_ amount: Int) {
        current += amount
    }
    
    func remove(_ amount: Int) {
        if (current > 0) {
            current -= amount
        }
    }
    
    var currentSum: Int {
        return current
    }
    
    nonisolated var bankName: String {
        return name
    }
}

class BankClass {
    private var current = 0
    
    func add(_ amount: Int) {
        current += amount
    }
    
    func remove(_ amount: Int) {
        if (current > 0) {
            current -= amount
        }
    }
    
    var currentSum: Int {
        return current
    }
}


