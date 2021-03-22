//
//  City.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

struct City {
    var id: Int
    var name: String
    var temperature: Double
    var pressure: Double
    var humidity: Double
    var description: String
    var coordinates: Coordinates
    
    static func === (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
}
