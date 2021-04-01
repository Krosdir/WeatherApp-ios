//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Krosdir on 30.03.2021.
//

import Foundation
import UIKit

protocol CoordinatorActionDelegate {
    func childCoordinatorDidFinish(_ coordinator: Coordinator)
    func attemptsToUpdateViewModel(with city: City)
}

protocol Coordinator: class, CoordinatorActionDelegate {
    var rootViewController: UIViewController { get }
    var parent: Coordinator? { get set }
}

extension Coordinator {
    func childCoordinatorDidFinish(_ coordinator: Coordinator) { }
    func attemptsToUpdateViewModel(with city: City) { }
}
