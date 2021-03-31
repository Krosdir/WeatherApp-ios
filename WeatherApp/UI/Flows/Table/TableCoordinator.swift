//
//  TableCoordinator.swift
//  WeatherApp
//
//  Created by Krosdir on 30.03.2021.
//

import Foundation
import UIKit

class TableCoordinator: NSObject, Coordinator {
    
    var rootViewController: UIViewController {
        self.rootNavigationController
    }
    
    var parent: Coordinator?
    
    private var tableViewController: TableViewController
    
    private var editCoordinator: EditCoordinator?
    
    private var rootNavigationController: UINavigationController
    
    override init() {
        
        let tableViewController = TableViewController.instantiate()
        self.tableViewController = tableViewController
        self.tableViewController.viewModel = TableViewModel()
        
        let navigationController = UINavigationController(rootViewController: self.tableViewController)
        self.rootNavigationController = navigationController
        
        super.init()
        
        self.rootNavigationController.delegate = self
        self.tableViewController.viewModel.actionDelegate = self
    }
    
    func chilgCoordinatorDidFinish(_ coordinator: Coordinator) {
        editCoordinator = nil
    }
    
}

// MARK: - TableViewModelActionDelegate
extension TableCoordinator: TableViewModelActionDelegate {
    func viewModel(_ viewModel: TableViewModelType, attemptsToOpenDetailAtIndexPath indexPath: IndexPath) {
        guard let detailViewModel = viewModel.detailViewModel(for: indexPath) else {
            print("ERROR: Can't get DetailViewModel for indexPath - \(indexPath)")
            return
        }
        
        let detailViewController = DetailViewController.instantiate()
        detailViewController.viewModel = detailViewModel
        detailViewController.viewModel.actionDelegate = self
        
        rootNavigationController.pushViewController(detailViewController, animated: true)
    }
    
    func viewModel(_ viewModel: TableViewModelType, attemptsToEditCityAtIndexPath indexPath: IndexPath) {
        guard let selectViewModel = viewModel.selectLocationViewModel(for: indexPath) else {
            print("ERROR: Can't get SelectLocationViewModel for indexPath - \(indexPath)")
            return
        }
        editCoordinator = EditCoordinator()
        editCoordinator?.parent = self
        editCoordinator?.start(with: selectViewModel, in: rootNavigationController)
        
    }
    
    func viewModelAttemptsToAddCity(_ viewModel: TableViewModelType) {
        let indexPath = IndexPath(row: viewModel.numberOfRows, section: 0)
        guard let selectViewModel = viewModel.selectLocationViewModel(for: indexPath) else {
            print("ERROR: Can't get SelectLocationViewModel for indexPath - \(indexPath)")
            return
        }
        editCoordinator = EditCoordinator()
        editCoordinator?.parent = self
        editCoordinator?.start(with: selectViewModel, in: rootNavigationController)
    }
}

// MARK: - DetailViewModelActionDelegate
extension TableCoordinator: DetailViewModelActionDelegate {
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
extension TableCoordinator: UINavigationControllerDelegate {
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
