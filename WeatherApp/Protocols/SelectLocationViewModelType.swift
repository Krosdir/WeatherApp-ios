//
//  SelectLocationViewViewModelType.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol SelectLocationViewModelType {
    var coordinates: Coordinates { get }
    func editTitleViewModel() -> EditTitleCityViewModelType?
    func fetchCity(coordinates: Coordinates)
}
