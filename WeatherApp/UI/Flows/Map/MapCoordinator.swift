//
//  MapCoordinator.swift
//  WeatherApp
//
//  Created by Krosdir on 30.03.2021.
//

import Foundation
import UIKit

class MapCoordinator: Coordinator {
    var rootViewController: UIViewController {
        self.rootNavigationController
    }
    
    var parent: Coordinator?
    
    var mapViewController: MapViewController
    
    var rootNavigationController: UINavigationController
    
    init() {
        let mapViewController = MapViewController.instantiate()
        self.mapViewController = mapViewController
        
        let navigationController = UINavigationController(rootViewController: self.mapViewController)
        self.rootNavigationController = navigationController
    }
    
    func chilgCoordinatorDidFinish(_ coordinator: Coordinator) {
        
    }
}
