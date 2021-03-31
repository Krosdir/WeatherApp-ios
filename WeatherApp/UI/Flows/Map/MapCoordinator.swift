//
//  MapCoordinator.swift
//  WeatherApp
//
//  Created by Krosdir on 30.03.2021.
//

import Foundation
import MapKit
import UIKit

class MapCoordinator: NSObject, Coordinator {
    var rootViewController: UIViewController {
        self.rootNavigationController
    }
    
    var parent: Coordinator?
    
    private var mapViewController: MapViewController
    
    private var editCoordinator: EditCoordinator?
    
    private var rootNavigationController: UINavigationController
    
    override init() {
        let mapViewController = MapViewController.instantiate()
        self.mapViewController = mapViewController
        self.mapViewController.viewModel = MapViewModel()
        
        let navigationController = UINavigationController(rootViewController: self.mapViewController)
        self.rootNavigationController = navigationController
        
        super.init()
        
        self.rootNavigationController.delegate = self
        self.mapViewController.viewModel.actionDelegate = self
    }
    
    func chilgCoordinatorDidFinish(_ coordinator: Coordinator) {
        editCoordinator = nil
    }
}

// MARK: - MapViewModelActionDelegate
extension MapCoordinator: MapViewModelActionDelegate {
    func viewModelAttemptsToAddCity(_ viewModel: MapViewModelType) {
        guard let selectViewModel = viewModel.selectLocationViewModel() else {
            print("ERROR: Can't get SelectLocationViewModel")
            return
        }
        editCoordinator = EditCoordinator()
        editCoordinator?.parent = self
        editCoordinator?.start(with: selectViewModel, in: rootNavigationController)
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
        guard let selectViewModel = viewModel.selectLocationViewModel() else {
            print("ERROR: Can't get SelectLocationViewModel")
            return
        }
        
        editCoordinator = EditCoordinator()
        editCoordinator?.parent = self
        editCoordinator?.start(with: selectViewModel, in: rootNavigationController)
    }
}

// MARK: - UINavigationControllerDelegate
extension MapCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              let nextController = navigationController.transitionCoordinator?.viewController(forKey: .to),
              previousController == editCoordinator?.selectLocationViewController &&
              nextController != editCoordinator?.editTitleViewController else {
            return
        }
        chilgCoordinatorDidFinish(editCoordinator!)
    }
}
