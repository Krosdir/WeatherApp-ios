//
//  MapCoordinator.swift
//  WeatherApp
//
//  Created by Krosdir on 30.03.2021.
//

import Foundation
import MapKit
import UIKit

class MapCoordinator: Coordinator {
    var rootViewController: UIViewController {
        self.rootNavigationController
    }
    
    var parent: Coordinator?
    
    private var mapViewController: MapViewController
    
    private var editCoordinator: EditCoordinator?
    
    private var rootNavigationController: UINavigationController
    private var beforeViewController: UIViewController?
    init() {
        let mapViewController = MapViewController.instantiate()
        self.mapViewController = mapViewController
        self.mapViewController.viewModel = MapViewModel()
        
        let navigationController = UINavigationController(rootViewController: self.mapViewController)
        self.rootNavigationController = navigationController

        self.mapViewController.viewModel.actionDelegate = self
    }
    
    func childCoordinatorDidFinish(_ coordinator: Coordinator) {
        guard editCoordinator === coordinator else {
            print("ERROR: No coordinator with that address")
            return
        }
        editCoordinator = nil
    }
    
    func attemptsToUpdateViewModel(with city: City) {
        mapViewController.viewModel.placeCity(city)
        
        guard let beforeViewController = self.beforeViewController as? DetailViewController else { return }
        
        beforeViewController.viewModel = DetailViewModel(city: city)
    }
}

// MARK: - MapViewModelActionDelegate
extension MapCoordinator: MapViewModelActionDelegate {
    func viewModelAttemptsToAddCity(_ viewModel: MapViewModelType) {
        editCoordinator = EditCoordinator()
        editCoordinator?.parent = self
        editCoordinator?.start(with: nil, in: rootNavigationController)
    }
    
    func viewModel(_ viewModel: MapViewModelType, attemptsToOpenDetailForAnnotation annotation: MKAnnotation) {
        guard let detailViewModel = viewModel.detailViewModel(for: annotation) else {
            print("ERROR: Can't get DetailViewModel for annotation - \(annotation)")
            return
        }
        
        let detailViewController = DetailViewController.instantiate()
        detailViewController.viewModel = detailViewModel
        detailViewController.viewModel.actionDelegate = self
        
        rootNavigationController.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - DetailViewModelActionDelegate
extension MapCoordinator: DetailViewModelActionDelegate {
    func viewModelAttemptsToEditCity(_ viewModel: DetailViewModelType) {
        editCoordinator = EditCoordinator()
        editCoordinator?.parent = self
        editCoordinator?.start(with: viewModel.getCity(), in: rootNavigationController)
    }
}
