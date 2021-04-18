//
//  TransactionsViewController.swift
//  TransactionBud
//
//  Created by George Cremer on 17/04/2021.
//

import UIKit

class TransactionsViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet var leftBarButtonItem: UIBarButtonItem!

    private var transactionsPresenter: TransactionsPresenter?
    private var transactions: [BudTransactionModel] = []

    private var transactionIdToHide: [String] = []

    private var deleteButton: DeleteButtonBottomTB!
    private var deleteButtonTopAnchor: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        configPresenter()
        configTableView()
        configNavBar()
        configDeleteButton()
    }

    override func viewWillAppear(_: Bool) {
        transactionsPresenter?.retrieveTransactions()
    }

    func configNavBar() {
        rightBarButtonItem.title = EditButtonStates.edit.title
        leftBarButtonItem.image = Images.menu

        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Transactions"
    }

    func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: "TransactionCell")
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelectionDuringEditing = true
    }

    func configPresenter() {
        if transactionsPresenter == nil {
            transactionsPresenter = TransactionsPresenter(networkManager: NetworkManager(), networkManagerDelegate: self, menuDelegate: self)
        }
    }

    func configDeleteButton() {
        let safeArea = UIApplication.bottomSafeAreaHeight
        let labelHeight: CGFloat = safeArea > 0 ? 40 : 50
        let buttonHeight: CGFloat = labelHeight + safeArea

        deleteButton = DeleteButtonBottomTB(backgroundColor: .systemRed, title: "Remove")
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deleteButton)

        deleteButtonTopAnchor = deleteButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        deleteButtonTopAnchor.isActive = true

        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: buttonHeight),
        ])
    }

    @objc func deleteButtonTapped() {
        if let selectedIndexes = tableView.indexPathsForSelectedRows {
            let sortedIndexes = selectedIndexes.sorted { $0.row > $1.row }

            sortedIndexes.forEach {
                transactionIdToHide.append(transactions[$0.row].id)
                transactions.remove(at: $0.row)
            }

            tableView.beginUpdates()
            tableView.deleteRows(at: sortedIndexes, with: .automatic)
            tableView.endUpdates()
        }
    }

    @IBAction func rightBarButtonPressed(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        sender.title = tableView.isEditing ? EditButtonStates.done.title : EditButtonStates.edit.title
        animateRemoveButton()
    }

    @IBAction func leftBarButtonPressed(_: UIBarButtonItem) {
        DispatchQueue.main.async {
            let alertVC = MenuAlertViewControllerTB()
            alertVC.menuDelegate = self
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }

    func animateRemoveButton() {
        let constraintConstant = tableView.isEditing ? -deleteButton.frame.height : 0
        deleteButtonTopAnchor.constant = constraintConstant

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension TransactionsViewController: NetworkManagerDelegate {
    func successfullyRetrieved(transactions: [BudTransactionModel]) {
        DispatchQueue.main.async { [self] in
            self.transactions = transactions
            tableView.reloadData()
        }
    }

    func errorHandler(error: ErrorsTB) {
        presentAlertOnMainThread(title: "Whoops 🤯", message: error.rawValue, buttonTitle: "OK")
    }
}

extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell") as! TransactionCell
        let transaction = transactions[indexPath.row]

        ImageCache.shared.retrieveImage(withUrl: transaction.productIcon, tag: transaction.value.description, complete: { image in
            DispatchQueue.main.async {
                cell.icon.image = image
            }
        })

        cell.title.text = transaction.description
        cell.category.text = transaction.category
        cell.amount.text = transaction.value.description

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            transactions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension TransactionsViewController: MenuDelegate {
    func resetPage() {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            rightBarButtonItem.title = EditButtonStates.edit.title
            animateRemoveButton()
            transactions.removeAll()
            transactionIdToHide.removeAll()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [self] in
            transactionsPresenter?.retrieveTransactions()
        }
    }

    func generateRandomError() {
        let error = ErrorsTB.allCases.randomElement()!
        presentAlertOnMainThread(title: "Whoops 🤯", message: error.rawValue, buttonTitle: "OK")
    }
}
