//
//  MyRepository.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/08/30.
//

import Foundation

protocol MyRepositoryProtocol {
    
}

final class MyRepository: MyRepositoryProtocol {
    
    init() {
        
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
