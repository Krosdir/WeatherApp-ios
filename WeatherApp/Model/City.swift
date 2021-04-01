//
//  City.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

struct City: Equatable {
    var id: Int
    var name: String
    var temperature: Double
    var pressure: Double
    var humidity: Double
    var description: String
    var coordinates: Coordinates
    
    typealias JSON = [String: AnyObject]
    
    init?(dict: [String: AnyObject]) {
        guard let id = ((dict["weather"]) as? [JSON])?.first?["id"] as? Int,
              let name = dict["name"] as? String,
              let temperature = (dict["main"] as? JSON)?["temp"] as? Double,
              let pressure = (dict["main"] as? JSON)?["pressure"] as? Double,
              let humidity = (dict["main"] as? JSON)?["humidity"] as? Double,
              let description = ((dict["weather"]) as? [JSON])?.first?["description"] as? String,
              let longitude = (dict["coord"] as? JSON)?["lon"] as? Double,
              let latitude = (dict["coord"] as? JSON)?["lat"] as? Double else { return nil }
        
        self.id = id
        self.name = name
        self.temperature = temperature
        self.pressure = pressure
        self.humidity = humidity
        self.description = description
        self.coordinates = Coordinates(longitude: longitude, latitude: latitude)
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }
}

extension City: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case temperature
        case pressure
        case humidity
        case description
        case coordinates
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        temperature = try values.decode(Double.self, forKey: .temperature)
        pressure = try values.decode(Double.self, forKey: .pressure)
        humidity = try values.decode(Double.self, forKey: .humidity)
        description = try values.decode(String.self, forKey: .description)
        coordinates = try values.decode(Coordinates.self, forKey: .coordinates)
    }
}
