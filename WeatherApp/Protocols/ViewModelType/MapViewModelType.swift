//
//  MapViewModelType.swift
//  WeatherApp
//
//  Created by Krosdir on 25.03.2021.
//

import Foundation
import MapKit

protocol MapViewModelType {
    var cityCoordinates: [Coordinates] { get }
    var displayDelegate: MapViewModelDisplayDelegate? { get set }
    var center: Coordinates { get }
    var mapScale: Double { get }
    var actionDelegate: MapViewModelActionDelegate? { get set }
    
    func getCity(forAnnotation annotation: MKAnnotation) -> City?
    func detailViewModel(for annotation: MKAnnotation) -> DetailViewModelType?
    func placeCity(_ city: City)
    func updateCities()
    
    func attemptsToAddCity(with viewModel: MapViewModelType)
    func attemptsToOpenDetails(with viewModel: MapViewModelType, forAnnotation annotation: MKAnnotation)
}
