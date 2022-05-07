//
//  CityViewCell.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 05.04.2022.
//

import UIKit

class CityViewCell: UITableViewCell {
    // MARK: - Properties
    private lazy var nameCity = makeLable(sizeFont: 18)
    private lazy var temperatureCity = makeLable(sizeFont: 18)
    private lazy var currentLocation = makeLable(sizeFont: 12)

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func setupCell(_ model: WeatherData, _ index: Int) {
        if index == 0 {
            currentLocation.text = "Текущее местоположение"
            currentLocation.textColor = .systemGray
        }
        nameCity.text = model.city.name
        temperatureCity.text = "\(model.list.first?.main.temp ?? 0.0)°"
    }

    private func layout() {
        [nameCity, temperatureCity, currentLocation].forEach { contentView.addSubview($0) }

        let indent: CGFloat = 8
        let width: CGFloat = (bounds.width - 4 * indent) / 3

        NSLayoutConstraint.activate([
            nameCity.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent),
            nameCity.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent),
            nameCity.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indent),

            currentLocation.topAnchor.constraint(equalTo: nameCity.topAnchor),
            currentLocation.leadingAnchor.constraint(equalTo: nameCity.trailingAnchor, constant: indent),
            currentLocation.widthAnchor.constraint(equalToConstant: width),
            currentLocation.bottomAnchor.constraint(equalTo: nameCity.bottomAnchor),

            temperatureCity.topAnchor.constraint(equalTo: nameCity.topAnchor),
            temperatureCity.leadingAnchor.constraint(greaterThanOrEqualTo: currentLocation.trailingAnchor, constant: indent),
            temperatureCity.bottomAnchor.constraint(equalTo: nameCity.bottomAnchor),
            temperatureCity.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indent)
        ])
    }
}
