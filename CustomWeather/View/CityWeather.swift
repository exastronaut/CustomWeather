//
//  CityWeather.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 06.05.2022.
//

import UIKit

class CityWeather: UIView {
    //MARK: - Properties
    private lazy var nameCity = makeLable(sizeFont: 24)
    private lazy var weatherDescription = makeLable(sizeFont: 16)
    private lazy var temperature = makeLable(sizeFont: 48)
    private lazy var maxMinTemperature = makeLable(sizeFont: 16)

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods

    func setupView(_ model: WeatherData) {
        nameCity.text = model.city.name
        weatherDescription.text = model.list.first?.weather.first?.description
        temperature.text = "\(model.list[0].main.temp)°"
        maxMinTemperature.text = "Макс. \(model.list[0].main.tempMax)°, мин. \(model.list[0].main.tempMin)°"
    }

    private func layout() {
        [nameCity, weatherDescription, temperature, maxMinTemperature].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            nameCity.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameCity.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: 16),

            weatherDescription.centerXAnchor.constraint(equalTo: nameCity.centerXAnchor),
            weatherDescription.topAnchor.constraint(equalTo: nameCity.bottomAnchor, constant: 8),

            temperature.centerXAnchor.constraint(equalTo: weatherDescription.centerXAnchor),
            temperature.topAnchor.constraint(equalTo: weatherDescription.bottomAnchor, constant: 8),

            maxMinTemperature.centerXAnchor.constraint(equalTo: temperature.centerXAnchor),
            maxMinTemperature.topAnchor.constraint(equalTo: temperature.bottomAnchor, constant: 8),
            maxMinTemperature.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -16)
        ])
    }
}
