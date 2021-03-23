//
//  SelectLocationViewViewModelType.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol SelectLocationViewViewModelType {
    var coordinates: Coordinates { get }
    func editTitleViewModel() -> EditTitleViewViewModelType?
    func editTitleViewModel(city: City) -> EditTitleViewViewModelType?
}
