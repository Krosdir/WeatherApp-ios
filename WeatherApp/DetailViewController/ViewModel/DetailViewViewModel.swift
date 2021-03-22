//
//  DetailViewViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

class DetailViewViewModel: DetailViewViewModelType {
    
    private var city: City!
    
    var name: String {
        return city.name
    }
    
    var temperature: String {
        return String(describing: city.temperature)
    }
    
    var pressure: String {
        return String(describing: city.pressure)
    }
    
    var humidity: String {
        return String(describing: city.humidity)
    }
    
    var description: String {
        return city.description
    }
    
    init(city: City) {
        self.city = city
    }
}
