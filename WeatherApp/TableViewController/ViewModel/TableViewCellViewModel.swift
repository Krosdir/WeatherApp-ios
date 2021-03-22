//
//  TableViewCellViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

class TableViewCellViewModel: TableViewCellViewModelType {
    private var city: City?
    
    var name: String {
        guard  let city = city else { return "" }
        return city.name + " " + String(describing: city.temperature)
    }
    
    init(city: City) {
        self.city = city
    }
}
