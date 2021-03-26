//
//  GetCityResponse.swift
//  WeatherApp
//
//  Created by Krosdir on 23.03.2021.
//

import Foundation

struct GetCityResponse {
    let city: City
    
    init?(json: Any) {
        guard let dictionary = json as? [String: AnyObject],
              let city = City(dict: dictionary) else { return nil }
        
        self.city = city
    }
}
