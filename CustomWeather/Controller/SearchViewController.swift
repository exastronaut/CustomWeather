//
//  SearchViewController.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 05.05.2022.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - Properties
    private var networkLocationManager = NetworkLocationManager()
    private var foundLocations = [LocationData]()
    private var timer = Timer()

    var completion: ((Double, Double) -> Void)?

    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    private var isFound: Bool {
        searchController.isActive && !searchBarIsEmpty
    }

    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search"
        return controller
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        customizeView()
        setupSearchController()
        layout()
    }
    
    // MARK: - Methods
    private func customizeView() {
        view.backgroundColor = .systemBackground
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }

    private func layout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFound {
            return foundLocations.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var content = cell.defaultContentConfiguration()
        let location = foundLocations[indexPath.row]
        if let state = location.state {
            content.text = "\(location.name), \(state), \(location.country)"
        } else {
            content.text = "\(location.name), \(location.country)"
        }
        cell.contentConfiguration = content
        return cell
    }


}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.dismiss(animated: true) { [weak self] in
            guard let self = self else { return } 
            self.completion?(self.foundLocations[indexPath.row].lat,
                             self.foundLocations[indexPath.row].lon)
        }
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text != "" else {
            return
        }
        networkLocationManager.fetchLocation(text: text) { [weak self] locations in
            self?.foundLocations = locations
        }
        tableView.reloadData()
    }
}

