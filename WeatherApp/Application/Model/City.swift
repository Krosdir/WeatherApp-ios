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
    
    // ugly parsing
    init?(dict: [String: AnyObject]) {
        var tempId = Int()
        var tempTemperature = Double()
        var tempPressure = Double()
        var tempHumidity = Double()
        var tempDescription = String()
        var tempLongitude = Double()
        var tempLatitude = Double()
        
        if let main = dict["main"] {
            if let temperature = main["temp"] as? Double{
                tempTemperature = temperature
            }
            if let pressure = main["pressure"] as? Double{
                tempPressure = pressure
            }
            if let humidity = main["humidity"] as? Double{
                tempHumidity = humidity
            }
        }
        
        if let coord = dict["coord"] {
            if let lon = coord["lon"] as? Double{
                tempLongitude = lon
            }
            if let lat = coord["lat"] as? Double{
                tempLatitude = lat
            }
        }
        
        if let weather = dict["weather"] {
            if let value = weather[0] as? NSDictionary{
                if let description = value["description"] as? String{
                    tempDescription = description
                }
                if let id = value["id"] as? Int{
                    tempId = id
                }
            }
        }

        guard let name = dict["name"] as? String else { return nil }
        
        self.id = tempId
        self.name = name
        self.temperature = tempTemperature
        self.pressure = tempPressure
        self.humidity = tempHumidity
        self.description = tempDescription
        self.coordinates = Coordinates(longitude: tempLongitude, latitude: tempLatitude)
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }
}
