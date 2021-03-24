//
//  CityNetworkService.swift
//  WeatherApp
//
//  Created by Krosdir on 23.03.2021.
//

import Foundation

class CityNetworkService {
    private init() {}
    
    static func getCities(completion: @escaping(GetCityResponse) -> ()) {
        Constants.cityNames.forEach { (name) in
            let link = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=\(Constants.apiKey)"
            guard let url = URL(string: link) else { return }
            
            NetworkService.shared.getData(url: url) { (json) in
                guard let response = GetCityResponse(json: json) else { return }
                completion(response)
            }
        }
    }
    
    static func getCityByCoordinates(coordinates: Coordinates, completion: @escaping(GetCityResponse) -> ()) {
        let link = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(Constants.apiKey)"
        guard let url = URL(string: link) else { return }
        
        NetworkService.shared.getData(url: url) { (json) in
            guard let response = GetCityResponse(json: json) else { return }
            completion(response)
        }
    }
}
