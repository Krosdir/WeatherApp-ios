//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Krosdir on 30.03.2021.
//

import Foundation
import UIKit

protocol CoordinatorActionDelegate {
    func chilgCoordinatorDidFinish(_ coordinator: Coordinator)
}

protocol Coordinator: class, CoordinatorActionDelegate {
    var rootViewController: UIViewController { get }
    var parent: Coordinator? { get set }
}

extension Coordinator {
    func chilgCoordinatorDidFinish(_ coordinator: Coordinator) { }
}
