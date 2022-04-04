//
//  CustomCell.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 04.04.2022.
//

import UIKit

class CustomCityListCell: UITableViewCell {

    // MARK: - Properties

    private let customContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()

    private let nameCity: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()

    private let temperatureCity: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customizeCell()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setupCell(model: CityModel) {
        nameCity.text = model.name
        temperatureCity.text = model.temperature
    }

    private func customizeCell() {
//        contentView.backgroundColor = .systemGray
    }

    private func layout() {
        [customContentView, stackView].forEach { contentView.addSubview($0) }

        [nameCity, temperatureCity].forEach { stackView.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            stackView.topAnchor.constraint(equalTo: customContentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor)

        ])
    }
}
