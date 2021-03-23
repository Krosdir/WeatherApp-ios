//
//  SelectLocationViewViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

class SelectLocationViewViewModel: SelectLocationViewViewModelType {
    
    private var city: City?
    
    var coordinates: Coordinates {
        guard let city = self.city else { return Coordinates(longitude: 0, latitude: 0) }
        return city.coordinates
    }
    
    init(city: City?) {
        self.city = city
    }
    
    func editTitleViewModel() -> EditTitleViewViewModelType? {
        return EditTitleViewViewModel(city: city)
    }
    
    func editTitleViewModel(city: City) -> EditTitleViewViewModelType? {
        return EditTitleViewViewModel(city: city)
    }
    
}
