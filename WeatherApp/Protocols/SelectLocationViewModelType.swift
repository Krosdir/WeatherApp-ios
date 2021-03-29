//
//  SelectLocationViewViewModelType.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol SelectLocationViewModelType {
    var coordinates: Coordinates { get }
    var displayDelegate: SelectLocationViewModelDisplayDelegate? { get set }
    func editTitleViewModel() -> EditTitleCityViewModelType?
    func fetchCity(coordinates: Coordinates)
}
