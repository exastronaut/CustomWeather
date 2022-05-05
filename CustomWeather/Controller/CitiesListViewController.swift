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
    private var citiesWeather = [WeatherModel()]

    private lazy var citiesTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemGray2
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
        view.backgroundColor = .systemGray2
        title = "Cities List"
    }

    @objc private func addCity() { }


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
        cell.setupCell(model: citiesWeather[indexPath.row])
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
            networkWeatherManager.fetchWeather(lat: lastLocation.coordinate.latitude, lon: lastLocation.coordinate.longitude) { [weak self] weatherModel in
                self?.citiesWeather[0] = weatherModel.first ?? WeatherModel()
                DispatchQueue.main.async {
                    self?.citiesTableView.reloadData()
                }
            }
        }
    }
}
