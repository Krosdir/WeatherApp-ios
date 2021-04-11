//
//  TableCoordinator.swift
//  WeatherApp
//
//  Created by Krosdir on 30.03.2021.
//

import Foundation
import UIKit

class TableCoordinator: Coordinator {
    
    var rootViewController: UIViewController {
        self.rootNavigationController
    }
    
    var parent: Coordinator?
    
    private var tableViewController: TableViewController
    
    private var editCoordinator: EditCoordinator?
    
    private var rootNavigationController: UINavigationController
    private var beforeViewController: UIViewController?
    
    init() {
        
        let tableViewController = TableViewController.instantiate()
        self.tableViewController = tableViewController
        self.tableViewController.viewModel = TableViewModel()
        self.tableViewController.viewModel.displayDelegate = tableViewController
        
        let navigationController = UINavigationController(rootViewController: self.tableViewController)
        self.rootNavigationController = navigationController
        
        self.tableViewController.viewModel.actionDelegate = self
    }
    
    func childCoordinatorDidFinish(_ coordinator: Coordinator) {
        guard editCoordinator === coordinator else {
            print("ERROR: There is not a coordinator with that address")
            return
        }
        editCoordinator = nil
        beforeViewController = nil
    }
    
    func attemptsToUpdateViewModel(with city: City) {
        tableViewController.viewModel.placeCity(city)
        
        guard let beforeViewController = self.beforeViewController as? DetailViewController else { return }
        
        beforeViewController.viewModel = DetailViewModel(city: city)
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
        guard let city = viewModel.getCity(at: indexPath) else {
            print("ERROR: Can't get city for indexPath - \(indexPath)")
            return
        }
        beforeViewController = rootNavigationController.topViewController
        
        editCoordinator = EditCoordinator()
        editCoordinator?.parent = self
        editCoordinator?.start(with: city, in: rootNavigationController)
        
    }
    
    func viewModelAttemptsToAddCity(_ viewModel: TableViewModelType) {
        beforeViewController = rootNavigationController.topViewController
        
        editCoordinator = EditCoordinator()
        editCoordinator?.parent = self
        editCoordinator?.start(with: nil, in: rootNavigationController)
    }
}

// MARK: - DetailViewModelActionDelegate
extension TableCoordinator: DetailViewModelActionDelegate {
    func viewModelAttemptsToEditCity(_ viewModel: DetailViewModelType) {
        beforeViewController = rootNavigationController.topViewController
        
        editCoordinator = EditCoordinator()
        editCoordinator?.parent = self
        editCoordinator?.start(with: viewModel.getCity(), in: rootNavigationController)
    }
}
