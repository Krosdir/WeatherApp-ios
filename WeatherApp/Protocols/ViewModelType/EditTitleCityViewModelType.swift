//
//  EditTitleViewViewModelType.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol EditTitleCityViewModelType {
    var name: String { get }
    var city: City? { get }
    var actionDelegate: EditTitleViewModelActionDelegate? { get set }
    
    func attemptsToUpdateCity(_ city: City)
}
