//
//  Coordinates.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

struct Coordinates {
    var longitude: Double
    var latitude: Double
    
    static var zero: Coordinates {
        return Coordinates(longitude: 0, latitude: 0)
    }
    
    static func == (lhs: Coordinates, rhs: Coordinates) -> Bool {
        return lhs.longitude == rhs.longitude &&
            lhs.latitude == rhs.latitude
    }
}
