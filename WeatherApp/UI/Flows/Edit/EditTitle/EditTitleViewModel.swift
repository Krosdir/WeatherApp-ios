//
//  EditTitleViewViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol EditTitleViewModelActionDelegate: class {
    func viewModel(_ viewModel: EditTitleCityViewModelType, attemptsUpdateCity city: City)
}

class EditTitleViewModel: EditTitleCityViewModelType {

    var city: City?
    weak var actionDelegate: EditTitleViewModelActionDelegate?
    
    var name: String {
        guard let city = self.city else { return "City Name" }
        return city.name
    }
    
    init(city: City?) {
        self.city = city
    }
    
    // MARK: - ActionDelegate
    func attemptsToUpdateCity(_ city: City) {
        actionDelegate?.viewModel(self, attemptsUpdateCity: city)
    }
}
