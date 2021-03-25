//
//  GetCityResponse.swift
//  WeatherApp
//
//  Created by Krosdir on 23.03.2021.
//

import Foundation

struct GetCityResponse {
    let cities: [City]
    
    init?(json: Any) {
        guard let dictionary = json as? [String: AnyObject] else { return nil }
        
        var cities = [City]()
        guard let city = City(dict: dictionary) else { return nil }
        cities.append(city)
        
        self.cities = cities
    }
}
