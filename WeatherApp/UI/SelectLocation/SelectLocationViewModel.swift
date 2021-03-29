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
        guard let city = self.city else { return Coordinates(longitude: 82.9346, latitude: 55.0415) }
        return city.coordinates
    }
    
    init(city: City?) {
        self.city = city
    }
    
    func editTitleViewModel() -> EditTitleCityViewModelType? {
        return EditTitleViewModel(city: city)
    }
    
    func fetchCity(coordinates: Coordinates) {
        do {
            try CityNetworkService.shared.getCity(by: coordinates) { (response) in
                self.city = response.city
            }
        } catch CityNetworkError.badURL {
            print("ERROR: Can't build a correct URL")
            
        } catch CityNetworkError.imposibleParsing {
            print("ERROR: Can't parse City model")
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
        
    }
    
}
