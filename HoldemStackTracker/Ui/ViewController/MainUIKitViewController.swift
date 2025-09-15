//
//  MainUIKitViewController.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/08/31.
//

import Combine
import UIKit

class MainUIKitViewController: UIViewController {

    private let viewModel: MainViewModel
    private var cancellables = Set<AnyCancellable>()

    // MARK: - UI Components

    // UIStackView for main content
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // Loading indicator view
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()

    // Console buttons container
    private lazy var tableMainConsoleContent: UIView = {
        let view = UIView()
        // Create Table Button
        let tableCreatorButton = ElevatedCardWithIconAndNameUIView(
            imageResKey: "home",
            labelTextKey: "label_create_table",
            onClick: { [weak self] in
                self?.viewModel.onClickTableCreator()
            }
        )
        tableCreatorButton.translatesAutoresizingMaskIntoConstraints = false

        // Join by QR Button
        let qrButton = ElevatedCardWithIconAndNameUIView(
            imageResKey: "qr_code_scanner",
            labelTextKey: "button_qr_scanner",
            onClick: { [weak self] in
                self?.viewModel.onClickJoinTableByQr()
            }
        )

        // Join by ID Button
        let idButton = ElevatedCardWithIconAndNameUIView(
            imageResKey: "edit",
            labelTextKey: "button_table_id_search",
            onClick: { [weak self] in
                print("onClick idButton")
                self?.viewModel.onClickJoinTableById()
            }
        )

        // 下部の2つのボタンを横並び
        let subButtonStack = UIStackView(arrangedSubviews: [qrButton, idButton])
        subButtonStack.axis = .horizontal
        subButtonStack.distribution = .fillEqually
        subButtonStack.spacing = 8
        subButtonStack.translatesAutoresizingMaskIntoConstraints = false

        // 全体を縦並び
        let verticalStack = UIStackView(
            arrangedSubviews: [
                newTableTitle,
                tableCreatorButton,
                joinTableTitle,
                subButtonStack,
            ]
        )
        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        verticalStack.alignment = .fill
        verticalStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(verticalStack)

        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: view.topAnchor),
            verticalStack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8
            ),
            verticalStack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8
            ),
            verticalStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            // tableCreatorButtonの横幅をverticalStackに合わせる
            tableCreatorButton.leadingAnchor.constraint(
                equalTo: verticalStack.leadingAnchor
            ),
            tableCreatorButton.trailingAnchor.constraint(
                equalTo: verticalStack.trailingAnchor
            ),
        ])
        return view
    }()

    private lazy var newTableTitle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = NSLocalizedString("button_create_table", comment: "")
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        return view
    }()

    private lazy var joinTableTitle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = NSLocalizedString("label_join_table", comment: "")
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        return view
    }()

    // Joined table card container
    private lazy var joinedTableCardContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let headerStack = UIStackView()
        headerStack.axis = .horizontal
        headerStack.spacing = 8
        headerStack.translatesAutoresizingMaskIntoConstraints = false

        let headerIcon = UIImageView(
            image: UIImage(systemName: "person.pin.fill")
        )
        headerIcon.tintColor = .label

        let headerLabel = UILabel()
        headerLabel.text = NSLocalizedString("label_join_table", comment: "")
        headerLabel.font = .preferredFont(forTextStyle: .body)

        headerStack.addArrangedSubview(headerIcon)
        headerStack.addArrangedSubview(headerLabel)
        headerStack.addArrangedSubview(UIView())  // Spacer

        let cardView = UIView()  // This would be JoinedTableCardView
        cardView.backgroundColor = .systemGray6
        cardView.layer.cornerRadius = 8
        cardView.translatesAutoresizingMaskIntoConstraints = false

        let cardTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleJoinedCardTapped)
        )
        cardView.addGestureRecognizer(cardTapGesture)

        view.addSubview(headerStack)
        view.addSubview(cardView)

        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 16
            ),
            headerStack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            headerStack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),

            cardView.topAnchor.constraint(
                equalTo: headerStack.bottomAnchor,
                constant: 16
            ),
            cardView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            cardView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        return view
    }()

    // MARK: - Initialization

    init() {
        self.viewModel = MainViewModel()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        title = "a"
        view.backgroundColor = .systemBackground

        view.addSubview(mainStackView)
        view.addSubview(loadingView)

        // Add components to the main stack
        mainStackView.addArrangedSubview(tableMainConsoleContent)

        // Set constraints for main views
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            mainStackView.bottomAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor
            ),

            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        // Initially hide the main content
        mainStackView.isHidden = true
        loadingView.startAnimating()
    }

    // MARK: - Binding

    private func bindViewModel() {
        // Observe shouldShowScreenLoading
        viewModel.uiState.$shouldShowScreenLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.mainStackView.isHidden = isLoading
                if isLoading {
                    self?.loadingView.startAnimating()
                } else {
                    self?.loadingView.stopAnimating()
                }
            }
            .store(in: &cancellables)

        // Observe dialogUiState to show/hide the sheet
        viewModel.dialogUiState.$joinByIdSheetUiState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sheetState in
                guard let self = self else { return }
                if sheetState != nil && self.presentedViewController == nil {
                    self.presentJoinByIdSheet(with: sheetState!)
                } else if sheetState == nil
                    && self.presentedViewController != nil
                {
                    self.presentedViewController?.dismiss(
                        animated: true,
                        completion: nil
                    )
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Actions

    @objc private func handleTableCreatorTapped() {
        viewModel.onClickTableCreator()
    }

    @objc private func handleJoinTableByQrTapped() {
        viewModel.onClickJoinTableByQr()
    }

    @objc private func handleJoinTableByIdTapped() {
        viewModel.onClickJoinTableById()
    }

    @objc private func handleJoinedCardTapped() {
        viewModel.onClickJoinedCard()
    }

    // MARK: - Dialog Presentation

    private func presentJoinByIdSheet(with uiState: JoinByIdContentUiState) {
        let sheetVC = UIViewController()  // Placeholder for your JoinByIdContent UIKit view controller
        sheetVC.view.backgroundColor = .systemBackground

        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 16
        vStack.translatesAutoresizingMaskIntoConstraints = false

        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(
            self,
            action: #selector(handleJoinByIdDialogDone),
            for: .touchUpInside
        )

        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(
            self,
            action: #selector(handleJoinByIdDialogCancel),
            for: .touchUpInside
        )

        let textField = UITextField()
        textField.placeholder = "Enter ID"
        textField.borderStyle = .roundedRect

        vStack.addArrangedSubview(textField)
        vStack.addArrangedSubview(doneButton)
        vStack.addArrangedSubview(cancelButton)

        sheetVC.view.addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(
                equalTo: sheetVC.view.topAnchor,
                constant: 16
            ),
            vStack.leadingAnchor.constraint(
                equalTo: sheetVC.view.leadingAnchor,
                constant: 16
            ),
            vStack.trailingAnchor.constraint(
                equalTo: sheetVC.view.trailingAnchor,
                constant: -16
            ),
        ])

        if let sheet = sheetVC.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in 150 })]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 16
        }

        present(sheetVC, animated: true)
    }

    @objc private func handleJoinByIdDialogDone() {
        viewModel.onClickJoinByIdDialogDone()
    }

    @objc private func handleJoinByIdDialogCancel() {
        viewModel.onDissmissRequestJoinByIdDialog()
    }
}
