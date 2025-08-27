//
//  CharactersViewController.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//
import UIKit
import Combine
import SwiftUI

final class CharactersViewController: UIViewController {
    
    private let viewModel = CharactersViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var filterButtons: [UIButton] = []

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Characters"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(named: "PrimaryText") ?? .black
        return label
    }()
    
    private let filterStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        return stack
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseId)
        table.separatorStyle = .none
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 200
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchCharacters()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        let allFilterButton = makeFilterButton(for: .all)
        allFilterButton.translatesAutoresizingMaskIntoConstraints = false
        let container = UIStackView(arrangedSubviews: [titleLabel, filterStack, allFilterButton, tableView])
        container.axis = .vertical
        container.spacing = 16
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            allFilterButton.widthAnchor.constraint(equalTo: filterStack.widthAnchor, multiplier: 1/3, constant: -filterStack.spacing)

        ])

        ["alive", "dead", "unknown"].forEach { status in
            let button = makeFilterButton(for: CharacterStatus(rawValue: status) ?? .all)
            filterButtons.append(button)
            filterStack.addArrangedSubview(button)
        }
        filterButtons.append(allFilterButton)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.$characters
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                self?.tableView.isScrollEnabled = !isLoading
            }
            .store(in: &cancellables)
    }
    
    private func makeFilterButton(for status: CharacterStatus) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.title = status.title
        config.baseForegroundColor = .label
        config.background.backgroundColor = .clear
        config.background.strokeColor = .systemGray
        config.background.strokeWidth = 1
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let button = UIButton(configuration: config, primaryAction: nil)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        button.addAction(UIAction { [weak self] _ in
            self?.viewModel.changeFilter(to: status)
            self?.updateFilterButtonSelection(selectedStatus: status)

        }, for: .touchUpInside)
        
        return button
    }
    private func updateFilterButtonSelection(selectedStatus: CharacterStatus) {
        for button in filterButtons {
            if button.configuration?.title == selectedStatus.title {
                button.configuration?.background.backgroundColor = .systemGray4
            } else {
                button.configuration?.background.backgroundColor = .clear
            }
        }
    }
}

// MARK: - TableView
extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharacterCell.reuseId,
            for: indexPath
        ) as? CharacterCell else {
            return UITableViewCell()
        }
        let character = viewModel.characters[indexPath.row]
        cell.configure(with: character)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
        let detailView = CharacterDetailView(character: character)
        let hostingController = UIHostingController(rootView: detailView)
        hostingController.modalPresentationStyle = .fullScreen
        navigationController?.present(hostingController, animated: true)
    }
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        let lastRowIndex = viewModel.characters.count - 1
        if indexPath.row == lastRowIndex {
            viewModel.fetchCharacters()
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        guard viewModel.isLoading else { return nil }
        
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        let container = UIView(frame: CGRect(x: 0, y: 0,
                                             width: tableView.bounds.width,
                                             height: 50))
        spinner.center = container.center
        container.addSubview(spinner)
        return container
    }

    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.isLoading ? 50 : 0
    }

}
