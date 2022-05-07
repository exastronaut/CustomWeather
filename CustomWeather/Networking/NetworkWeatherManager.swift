//
//  NetworkWeatherManager.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 04.05.2022.
//

import Foundation

struct NetworkWeatherManager {
    func fetchWeather(
        lat: Double,
        lon: Double,
        completionHandler: @escaping (WeatherData) -> Void
    ) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat.description)&lon=\(lon.description)&appid=\(appID)&units=metric&lang=ru") else {
            print("invalid login URL")
            return
        }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                completionHandler(weatherData)
            } catch {
                print(error)
            }
        }.resume()
    }
}
