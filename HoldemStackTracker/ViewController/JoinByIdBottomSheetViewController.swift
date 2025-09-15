import UIKit

class JoinByIdBottomSheetViewController: UIViewController {
    // 入力されたIDを取得するためのプロパティ
    private(set) var enteredId: String? = nil

    // Done/Cancelアクション
    var onDone: ((String?) -> Void)?
    var onCancel: (() -> Void)?

    private let textField = UITextField()
    private let doneButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        textField.placeholder = "Enter ID"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false

        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
    
        doneButton.translatesAutoresizingMaskIntoConstraints = false

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        let vStack = UIStackView(arrangedSubviews: [textField, doneButton, cancelButton])
        vStack.axis = .vertical
        vStack.spacing = 16
        vStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    @objc private func handleDone() {
        enteredId = textField.text
        onDone?(enteredId)
    }

    @objc private func handleCancel() {
        onCancel?()
    }
}
