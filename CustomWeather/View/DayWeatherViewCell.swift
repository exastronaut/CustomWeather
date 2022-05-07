//
//  DayWeatherViewCell.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 06.05.2022.
//

import UIKit

class DayWeatherViewCell: UICollectionViewCell {
    //MARK: - Properties
    private lazy var day = makeLable(sizeFont: 18)
    private lazy var temp = makeLable(sizeFont: 18)

    private let icon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    func setupCell(_ model: WeatherData, _ index: Int) {
        let i = (index + 1) * 7 + index + 1
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSinceReferenceDate: Double((model.list[i].dt)))
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        day.text = dateFormatter.string(from: date)
        temp.text = "\(model.list[i].main.temp)°"
        icon.image = UIImage(named: model.list[i].weather[0].icon)
    }

    private func layout() {
        [day, icon, temp].forEach { contentView.addSubview($0) }

        let size: CGFloat = contentView.bounds.height - 24

        NSLayoutConstraint.activate([
            day.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            day.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            day.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor),

            icon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            icon.heightAnchor.constraint(equalToConstant: size),
            icon.widthAnchor.constraint(equalToConstant: size),

            temp.topAnchor.constraint(equalTo: day.topAnchor),
            temp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            temp.bottomAnchor.constraint(equalTo: day.bottomAnchor)
        ])
    }
}
