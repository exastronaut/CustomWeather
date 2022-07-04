//
//  CitiesListViewController.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 05.04.2022.
//

import UIKit
import CoreLocation

class CitiesListViewController: UIViewController {

    // MARK: - Properties

    private let networkWeatherManager = NetworkWeatherManager()
    private let locationManager = CLLocationManager()
    private var citiesWeather = [WeatherData()]

    private lazy var citiesTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(CityViewCell.self, forCellReuseIdentifier: CityViewCell.identifier)
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
        startLocationManager()
    }


    // MARK: - Methods

    private func customizeView() {
        view.backgroundColor = .systemBackground
        title = "CustomWeather"
    }

    @objc private func addCity() {
        let searchViewController = SearchViewController()
        let navigationController = UINavigationController(rootViewController: searchViewController)
        present(navigationController, animated: true) {
            searchViewController.completion = {  [weak self] lat, lon in
                guard let self = self else { return }
                self.networkWeatherManager.fetchWeather(lat: lat, lon: lon) { [weak self] weatherData in
                    guard let self = self else { return }
                    self.citiesWeather.append(weatherData)
                    DispatchQueue.main.async {
                        self.citiesTableView.reloadData()
                    }
                }
            }
        }
    }

    private func layout() {
        [citiesTableView, addCityButton].forEach{ view.addSubview($0) }

        NSLayoutConstraint.activate([
            citiesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            citiesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            citiesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            addCityButton.topAnchor.constraint(equalTo: citiesTableView.bottomAnchor),
            addCityButton.leadingAnchor.constraint(equalTo: citiesTableView.leadingAnchor),
            addCityButton.trailingAnchor.constraint(equalTo: citiesTableView.trailingAnchor),
            addCityButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addCityButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

// MARK: - UITableViewDelegate
extension CitiesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityWeatherViewController = CityWeatherViewController()
        cityWeatherViewController.model = citiesWeather[indexPath.row]
        navigationController?.pushViewController(cityWeatherViewController, animated: true)
    }

}

// MARK: - UITableViewDataSource

extension CitiesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        citiesWeather.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityViewCell.identifier, for: indexPath) as? CityViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(citiesWeather[indexPath.row], indexPath.row)
        return cell
    }

}

// MARK: - CLLocationManagerDelegate

extension CitiesListViewController: CLLocationManagerDelegate {

    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            networkWeatherManager.fetchWeather(lat: lastLocation.coordinate.latitude, lon: lastLocation.coordinate.longitude) { [weak self] weatherData in
                guard let self = self else { return }
                self.citiesWeather[0] = weatherData
                DispatchQueue.main.async {
                    self.citiesTableView.reloadData()
                }
            }
        }
    }
}
