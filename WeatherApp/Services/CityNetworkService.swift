//
//  CityNetworkService.swift
//  WeatherApp
//
//  Created by Krosdir on 23.03.2021.
//

import Foundation

enum Err: Error {
    case errrr
}

class CityNetworkService {
    private init() {}
    
    static func getCities(completion: @escaping([City], Error?) -> ()) {
        let group = DispatchGroup()
        var cities = [City]()
        Constants.cityNames.forEach { (name) in
            let link = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=\(Constants.apiKey)"
            guard let url = URL(string: link) else { return }
            
            group.enter()
            NetworkService.shared.getData(url: url) { (json) in
                guard let response = GetCityResponse(json: json as Any) else { return }
                    cities.append(response.city)
                    group.leave()
            }
        }
        
        group.wait()
        completion(cities, nil)
    }
    
    static func getCity(by coordinates: Coordinates, completion: @escaping(GetCityResponse) -> ()) {
        let link = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(Constants.apiKey)"
        guard let url = URL(string: link) else { return }
        
        NetworkService.shared.getData(url: url) { (json) in
            guard let response = GetCityResponse(json: json) else { return }
            completion(response)
        }
    }
}
