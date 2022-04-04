//
//  CityListController.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 04.04.2022.
//

import UIKit

class CityListViewController: UIViewController {

    // MARK: - Properties

    let city = CityModel.makeMockModel()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(CustomCityListCell.self, forCellReuseIdentifier: CustomCityListCell.identifier)
        return table
    }()

    private lazy var addCityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(addCity), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        layout()
    }

    // MARK: - Methods

    private func customizeView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
    }

    @objc func addCity() {

    }

    private func layout() {
        [tableView, addCityButton].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addCityButton.topAnchor),

            addCityButton.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            addCityButton.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            addCityButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            addCityButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addCityButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - Extensions

extension CityListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        city.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCityListCell.identifier, for: indexPath) as? CustomCityListCell else {
            return UITableViewCell()
        }
        cell.setupCell(model: city[indexPath.row])
        return cell
    }
}

extension CityListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
