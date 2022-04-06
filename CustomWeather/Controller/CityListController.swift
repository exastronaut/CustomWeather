//
//  CityListController.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 05.04.2022.
//

import UIKit

class CityListController: UIViewController {

    // MARK: - Properties

    let city = CityModel.makeMockModel()

    private let cityListView: CityListView = {
        let view = CityListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        customize()
        configureTableView()
        layout()
    }

    // MARK: - Methods

    private func customize() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
    }

    private func configureTableView() {
        cityListView.tableView.delegate = self
        cityListView.tableView.dataSource = self
        cityListView.tableView.register(CityListCell.self, forCellReuseIdentifier: CityListCell.identifier)
    }

    private func layout() {
        view.addSubview(cityListView)

        NSLayoutConstraint.activate([
            cityListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cityListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cityListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Extensions

extension CityListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension CityListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        city.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityListCell.identifier, for: indexPath) as? CityListCell else {
            return UITableViewCell()
        }
        cell.setupCell(model: city[indexPath.row])
        return cell
    }
}
