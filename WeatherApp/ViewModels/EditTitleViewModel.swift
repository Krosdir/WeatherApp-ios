//
//  EditTitleViewViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

class EditTitleViewModel: EditTitleCityViewModelType {

    var city: City? 
    
    var name: String {
        guard let city = self.city else { return "City Name" }
        return city.name
    }
    
    init(city: City?) {
        self.city = city
    }
    
}
