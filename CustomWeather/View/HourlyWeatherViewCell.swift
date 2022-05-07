//
//  HourlyWeatherViewCell.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 06.05.2022.
//

import UIKit

class HourlyWeatherViewCell: UICollectionViewCell {
    //MARK: - Properties

    private lazy var day = makeLable(sizeFont: 18)
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
            day.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            day.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor),

            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: day.leadingAnchor),
            icon.trailingAnchor.constraint(equalTo: day.trailingAnchor),
            icon.heightAnchor.constraint(equalToConstant: size),
            icon.widthAnchor.constraint(equalToConstant: size),

            temp.leadingAnchor.constraint(equalTo: icon.leadingAnchor),
            temp.trailingAnchor.constraint(equalTo: icon.trailingAnchor),
            temp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
