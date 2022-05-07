//
//  CityWeatherViewController.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 06.05.2022.
//

import UIKit

class CityWeatherViewController: UIViewController {
    // MARK: - Properties
    var model: WeatherData?

    private let cityWeather: CityWeather = {
        let view = CityWeather()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var horizontalCollection = makeCollectionView(scrollDirection: .horizontal)
    private lazy var verticalCollection = makeCollectionView(scrollDirection: .vertical)


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupCollections()
        customizeView()
    }

    // MARK: - Methods
    private func customizeView() {
        let model = model ?? WeatherData()
        cityWeather.setupView(model)
        view.backgroundColor = .systemBackground
    }

    private func setupCollections() {
        horizontalCollection.delegate = self
        horizontalCollection.dataSource = self
        horizontalCollection.register(HourlyWeatherViewCell.self, forCellWithReuseIdentifier: HourlyWeatherViewCell.identifier)

        verticalCollection.dataSource = self
        verticalCollection.delegate = self
        verticalCollection.register(DayWeatherViewCell.self, forCellWithReuseIdentifier: DayWeatherViewCell.identifier)
    }

    private func layout() {
        view.addSubview(horizontalCollection)
        [cityWeather, horizontalCollection, verticalCollection].forEach{ view.addSubview($0) }

        let height: CGFloat = UIScreen.main.bounds.height / 3


        NSLayoutConstraint.activate([
            cityWeather.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cityWeather.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cityWeather.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cityWeather.heightAnchor.constraint(equalToConstant: height),

            horizontalCollection.topAnchor.constraint(equalTo: cityWeather.bottomAnchor),
            horizontalCollection.leadingAnchor.constraint(equalTo: cityWeather.leadingAnchor),
            horizontalCollection.trailingAnchor.constraint(equalTo: cityWeather.trailingAnchor),
            horizontalCollection.heightAnchor.constraint(equalToConstant: height / 2),

            verticalCollection.topAnchor.constraint(equalTo: horizontalCollection.bottomAnchor),
            verticalCollection.leadingAnchor.constraint(equalTo: horizontalCollection.leadingAnchor),
            verticalCollection.trailingAnchor.constraint(equalTo: horizontalCollection.trailingAnchor),
            verticalCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension CityWeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == horizontalCollection {
            return 8
        } else {
            return 4
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == horizontalCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherViewCell.identifier, for: indexPath) as! HourlyWeatherViewCell
            cell.setupCell(model ?? WeatherData(), indexPath.row)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayWeatherViewCell.identifier, for: indexPath) as! DayWeatherViewCell
            cell.setupCell(model ?? WeatherData(), indexPath.row)
            return cell
        }
    }

}
//MARK: - UICollectionViewDelegateFlowLayout
extension CityWeatherViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == horizontalCollection {
            let width = (horizontalCollection.bounds.width - sideInset * 6) / 5
            let height = horizontalCollection.bounds.height - 2 * sideInset
            return CGSize(width: width, height: height)
        } else {
            let width = verticalCollection.bounds.width - 2 * sideInset
            let height = (verticalCollection.bounds.height - 5 * sideInset) / 4
            return CGSize(width: width, height: height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
}
