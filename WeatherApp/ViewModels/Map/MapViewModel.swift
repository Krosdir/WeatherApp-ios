//
//  MapViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 25.03.2021.
//

import Foundation

class MapViewModel: MapViewModelType {
    
    private var cities = [City]()
    
    var cityNames: [String] {
        return cities.map { $0.name }
    }
    
    var cityCoordinates: [Coordinates] {
        return cities.map { $0.coordinates }
    }
    
    init() {
        CityNetworkService.getCities { (response) in
            self.cities += response.cities
//            self.delegate?.reloadTable()
        }
    }
}
