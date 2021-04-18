//
//  MenuAlertViewControllerTB.swift
//  TransactionBud
//
//  Created by George Cremer on 18/04/2021.
//

import UIKit

class MenuAlertViewControllerTB: UIViewController {
    let containerView = ContainerViewTB()
    let titleLabel = TitleLabelTB(textAlignment: .center, fontSize: 20)
    let messageLabel = BodyLabelTB(textAlignment: .center)
    let resetButton = ButtonTB(backgroundColor: .black, title: "Reset")
    let errorGenerator = ButtonTB(backgroundColor: .black, title: "Random error generator")

    weak var menuDelegate: MenuDelegate?

    let padding: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubview(containerView)
        view.addSubview(titleLabel)
        view.addSubview(errorGenerator)
        view.addSubview(resetButton)
        view.addSubview(messageLabel)

        configureContainerView()
        configureTitleLabel()
        configureErrorButton()
        configureResetButton()
        configureMessageLabel()
    }

    func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 230),
        ])
    }

    func configureTitleLabel() {
        titleLabel.text = "Menu"

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
        ])
    }

    func configureErrorButton() {
        errorGenerator.setTitle("Generate a random error", for: .normal)
        errorGenerator.addTarget(self, action: #selector(errorButtonPressed), for: .touchUpInside)

        NSLayoutConstraint.activate([
            errorGenerator.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            errorGenerator.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            errorGenerator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            errorGenerator.heightAnchor.constraint(equalToConstant: 44),

        ])
    }

    func configureResetButton() {
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)

        NSLayoutConstraint.activate([
            resetButton.bottomAnchor.constraint(equalTo: errorGenerator.topAnchor, constant: -padding),
            resetButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            resetButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            resetButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }

    func configureMessageLabel() {
        messageLabel.text = "What shall we do? 🤔"
        messageLabel.numberOfLines = 4
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -12),
        ])
    }

    @objc func errorButtonPressed() {
        dismiss(animated: true, completion: menuDelegate?.generateRandomError)
    }

    @objc func resetButtonPressed() {
        dismiss(animated: true, completion: menuDelegate?.resetPage)
    }
}
