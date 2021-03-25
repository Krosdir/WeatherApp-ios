//
//  MapViewModelType.swift
//  WeatherApp
//
//  Created by Krosdir on 25.03.2021.
//

import Foundation

protocol MapViewModelType {
    var cityNames: [String] { get }
    var cityCoordinates: [Coordinates] { get }
}
