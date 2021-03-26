//
//  SelectLocationViewViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

class SelectLocationViewModel: SelectLocationViewModelType {
    
    private var city: City?
    
    var coordinates: Coordinates {
        guard let city = self.city else { return Coordinates(longitude: 0, latitude: 0) }
        return city.coordinates
    }
    
    init(city: City?) {
        self.city = city
    }
    
    func editTitleViewModel() -> EditTitleCityViewModelType? {
        return EditTitleViewModel(city: city)
    }
    
    func fetchCity(coordinates: Coordinates) {
        CityNetworkService.getCity(by: coordinates) { (response) in
            self.city = response.city
        }
    }
    
}
