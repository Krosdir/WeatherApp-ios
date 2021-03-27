//
//  CityNetworkService.swift
//  WeatherApp
//
//  Created by Krosdir on 23.03.2021.
//

import Foundation

enum CityNetworkError: Error {
    case badURL
    case imposibleParsing
}

class CityNetworkService {
    private init() {}
    static let shared = CityNetworkService()
    
     func getCities(completion: @escaping([City]) -> ()) throws {
        let group = DispatchGroup()
        var cities = [City]()
        try Constants.cityNames.forEach { (name) in
            let link = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=\(Constants.apiKey)"
            guard let url = URL(string: link) else {
                throw CityNetworkError.badURL
            }
            
            group.enter()
            try NetworkService.shared.getData(url: url) { (json) in
                guard let response = GetCityResponse(json: json as Any) else {
                    throw CityNetworkError.imposibleParsing
                }
                    cities.append(response.city)
                    group.leave()
            }
        }
        
        group.wait()
        completion(cities)
    }
    
    func getCity(by coordinates: Coordinates, completion: @escaping(GetCityResponse) -> ()) throws {
        let link = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(Constants.apiKey)"
        guard let url = URL(string: link) else {
            throw CityNetworkError.badURL
        }
        
        try NetworkService.shared.getData(url: url) { (json) in
            guard let response = GetCityResponse(json: json) else {
                throw CityNetworkError.imposibleParsing
            }
            completion(response)
        }
    }
}
