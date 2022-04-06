//
//  CityListView.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 05.04.2022.
//

import UIKit

class CityListView: UIView {

    // MARK: - Properties

    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private let addCityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
//        button.addTarget(self, action: #selector(addCity), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func layout() {
        [tableView, addCityButton].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addCityButton.topAnchor),

            addCityButton.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            addCityButton.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            addCityButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            addCityButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            addCityButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
