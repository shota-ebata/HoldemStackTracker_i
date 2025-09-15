//
//  ElevatedCardWithIconAndNameUIView.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/09/15.
//

import UIKit

class ElevatedCardWithIconAndNameUIView: UIView {
    private let imageView = UIImageView()
    private let label = UILabel()
    private var onClick: (() -> Void)?

    // labelTextKey: ローカライズキーを指定
    init(imageResKey: String?, labelTextKey: String, onClick: (() -> Void)? = nil) {
        super.init(frame: .zero)
        self.onClick = onClick
        setupView(imageResKey: imageResKey, labelTextKey: labelTextKey)
        setupGesture()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(imageResKey: nil, labelTextKey: "")
        setupGesture()
    }

    // labelTextKey を使ってローカライズテキストを取得
    private func setupView(imageResKey: String?, labelTextKey: String) {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)

        let stack = UIStackView(arrangedSubviews: [])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false

        if let imageName = imageResKey, let image = UIImage(named: imageName) {
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .label
            stack.addArrangedSubview(imageView)
        }

        // ローカライズテキスト取得
        let localizedText = NSLocalizedString(labelTextKey, comment: "")
        label.text = localizedText
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        stack.addArrangedSubview(label)

        self.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }

    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }

    @objc private func handleTap() {
        onClick?()
    }
}
