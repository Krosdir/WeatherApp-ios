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
    
    static func != (lhs: Coordinates, rhs: Coordinates) -> Bool {
        return lhs.longitude != rhs.longitude ||
            lhs.latitude != rhs.latitude
    }
}

extension Coordinates: Codable {
    
    enum CodingKeys: String, CodingKey {
        case longitude
        case latitude
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        longitude = try values.decode(Double.self, forKey: .longitude)
        latitude = try values.decode(Double.self, forKey: .latitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
}
