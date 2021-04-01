//
//  EditCoordinator.swift
//  WeatherApp
//
//  Created by Krosdir on 30.03.2021.
//

import Foundation
import UIKit

class EditCoordinator: NSObject, Coordinator {
    
    var rootViewController: UIViewController {
        self.rootNavigationController
    }
    
    var parent: Coordinator?
    
    var selectLocationViewController: SelectLocationViewController
    var editTitleViewController: EditTitleViewController
    
    private var rootNavigationController: UINavigationController!
    
    override init() {
        self.selectLocationViewController = SelectLocationViewController.instantiate()
        
        self.editTitleViewController = EditTitleViewController.instantiate()
        
        super.init()
    }
    
    func start(with city: City?, in navigationController: UINavigationController) {
        selectLocationViewController.viewModel = SelectLocationViewModel(city: city)
        selectLocationViewController.viewModel.actionDelegate = self
        rootNavigationController = navigationController
        rootNavigationController.delegate = self
        
        rootNavigationController.pushViewController(selectLocationViewController, animated: true)
    }
    
}

// MARK: - SelectLocationViewModelActionDelegate
extension EditCoordinator: SelectLocationViewModelActionDelegate {
    func viewModelAttemptsToContinueEditing(_ viewModel: SelectLocationViewModelType) {
        guard let editViewModel = viewModel.editTitleViewModel() else {
            print("ERROR: Can't get EditTitleViewModel")
            return
        }
        
        editTitleViewController.viewModel = editViewModel
        editTitleViewController.viewModel.actionDelegate = self
        
        rootNavigationController.pushViewController(editTitleViewController, animated: true)
    }
}

// MARK: - EditTitleViewModelActionDelegate
extension EditCoordinator: EditTitleViewModelActionDelegate {
    func viewModel(_ viewModel: EditTitleCityViewModelType, attemptsUpdateCity city: City) {
        parent?.attemptsToUpdateViewModel(with: city)
//        self.editTitleViewController.delegate?.viewModel(city, attemptsToEditName: name)
        parent?.childCoordinatorDidFinish(self)
        rootNavigationController.popToViewController(selectLocationViewController, animated: false)
        rootNavigationController.popViewController(animated: true)
        
    }
}

// MARK: - UINavigationControllerDelegate
extension EditCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              let nextController = navigationController.transitionCoordinator?.viewController(forKey: .to),
              previousController == selectLocationViewController &&
              nextController != editTitleViewController else {
            return
        }
        parent?.childCoordinatorDidFinish(self)
    }
}
