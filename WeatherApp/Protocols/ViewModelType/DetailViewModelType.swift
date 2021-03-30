//
//  DetailViewViewModelType.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol DetailViewModelType {
    var name: String { get }
    var temperature: String { get }
    var pressure: String { get }
    var humidity: String { get }
    var description: String { get }
    
    func selectLocationViewModel() -> SelectLocationViewModelType?
}
