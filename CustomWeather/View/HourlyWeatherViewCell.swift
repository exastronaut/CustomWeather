//
//  HourlyWeatherViewCell.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 06.05.2022.
//

import UIKit

class HourlyWeatherViewCell: UICollectionViewCell {
    //MARK: - Properties

    private lazy var day = makeLable(sizeFont: 16)
    private lazy var temp = makeLable(sizeFont: 14)

    private let icon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    func setupCell(_ model: WeatherData, _ index: Int) {
        let date = Date(timeIntervalSinceReferenceDate: Double((model.list[index].dt)))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        day.text = dateFormatter.string(from: date)
        temp.text = "\(model.list[index].main.temp)°"
        icon.image = UIImage(named: model.list[index].weather[0].icon)
    }

    private func layout() {
        [day, icon, temp].forEach { contentView.addSubview($0) }

        let size: CGFloat = contentView.bounds.width - 2

        NSLayoutConstraint.activate([
            day.topAnchor.constraint(equalTo: contentView.topAnchor),
            day.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            icon.heightAnchor.constraint(equalToConstant: size),
            icon.widthAnchor.constraint(equalToConstant: size),

            temp.centerXAnchor.constraint(equalTo: day.centerXAnchor),
            temp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
