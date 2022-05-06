//
//  NetworkLocationManager.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 05.05.2022.
//

import Foundation

struct NetworkLocationManager {
    func fetchLocation(text: String, completionHandler: @escaping ([LocationModel]) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&limit=5&appid=\(appID)") else {
            print("invalid login URL")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let locationData = try decoder.decode([LocatioData].self, from: data)
                var сities = [LocationModel]()
                locationData.forEach { location in
                    сities.append(contentsOf: LocationModel().makeModel(location))
                }
                completionHandler(сities)
            } catch {
                print(error)
            }
        }.resume()
    }
}
