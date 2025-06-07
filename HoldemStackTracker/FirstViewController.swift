//
//  FirstViewController.swift
//  HogeStoryboard
//
//  Created by 江幡将太 on 2025/06/03.
//

import UIKit
import SwiftUI

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "1画面目"

        let button = UIButton(type: .system)
        button.setTitle("次へ", for: .normal)
        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func didTapNext() {
        // 次の画面へ遷移する
//        let nextVC = NextViewController()
//        navigationController?.pushViewController(nextVC, animated: true)
        
        // SwiftUIの画面を表示する
        let mainContentView = MainContentView()
        let vc = UIHostingController(rootView: mainContentView)
        navigationController?.pushViewController(vc, animated: true)
    }
}
