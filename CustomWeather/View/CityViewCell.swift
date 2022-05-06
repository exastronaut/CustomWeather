//
//  CityViewCell.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 05.04.2022.
//

import UIKit

class CityViewCell: UITableViewCell {

    // MARK: - Properties
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
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setupCell(model: WeatherModel) {
        nameCity.text = model.name
        temperatureCity.text = "\(model.temp)°"
    }

    private func layout() {
        [nameCity, temperatureCity].forEach { contentView.addSubview($0) }

        let indent: CGFloat = 8

        NSLayoutConstraint.activate([
            nameCity.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent),
            nameCity.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent),
            nameCity.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indent),

            temperatureCity.topAnchor.constraint(equalTo: nameCity.topAnchor),
            temperatureCity.leadingAnchor.constraint(greaterThanOrEqualTo: nameCity.trailingAnchor, constant: indent),
            temperatureCity.bottomAnchor.constraint(equalTo: nameCity.bottomAnchor),
            temperatureCity.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indent)
        ])
    }
}
