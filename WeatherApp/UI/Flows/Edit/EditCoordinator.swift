//
//  EditCoordinator.swift
//  WeatherApp
//
//  Created by Krosdir on 30.03.2021.
//

import Foundation
import UIKit

class EditCoordinator: Coordinator {
    
    var rootViewController: UIViewController {
        self.rootNavigationController
    }
    
    var parent: Coordinator?
    
    var selectLocationViewController: SelectLocationViewController
    var editTitleViewController: EditTitleViewController
    
    private var rootNavigationController: UINavigationController!
    
    init() {
        self.selectLocationViewController = SelectLocationViewController.instantiate()
        
        self.editTitleViewController = EditTitleViewController.instantiate()
    }
    
    func start(with viewModel: SelectLocationViewModelType, in navigationController: UINavigationController) {
        selectLocationViewController.viewModel = viewModel
        selectLocationViewController.viewModel.actionDelegate = self
        rootNavigationController = navigationController
        
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
    func viewModel(_ viewModel: EditTitleCityViewModelType, attemptsUpdateCity city: City, withName name: String) {
        if name.isEmpty {
            self.editTitleViewController.delegate?.viewModel(city, attemptsToEditName: viewModel.name)
        } else {
            self.editTitleViewController.delegate?.viewModel(city, attemptsToEditName: name)
        }
        parent?.chilgCoordinatorDidFinish(self)
        rootNavigationController.popToRootViewController(animated: true)
        
    }
}
