//
//  NetworkLocationManager.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 05.05.2022.
//

import Foundation

struct NetworkLocationManager {
    func fetchLocation(text: String, completionHandler: @escaping ([LocationData]) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&limit=5&appid=\(appID)") else {
            print("invalid login URL")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let locations = try decoder.decode([LocationData].self, from: data)
                completionHandler(locations)
            } catch {
                print(error)
            }
        }.resume()
    }
}
