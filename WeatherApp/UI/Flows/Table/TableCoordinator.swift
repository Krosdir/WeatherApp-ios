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
    
    var tableViewController: TableViewController
    
    var editCoordinator: EditCoordinator?
    
    var rootNavigationController: UINavigationController
    
    init() {
        
        let tableViewController = TableViewController.instantiate()
        self.tableViewController = tableViewController
        self.tableViewController.viewModel = TableViewModel()
        
        let navigationController = UINavigationController(rootViewController: self.tableViewController)
        self.rootNavigationController = navigationController
        
        self.tableViewController.viewModel.actionDelegate = self
    }
    
    func chilgCoordinatorDidFinish(_ coordinator: Coordinator) {

    }
    
}

extension TableCoordinator: TableViewModelActionDelegate {
    func viewModel(_ viewModel: TableViewModelType, attemptsToOpenDetailAtIndexPath indexPath: IndexPath) {
        guard let detailViewModel = viewModel.detailViewModel(for: indexPath) else {
            print("ERROR: Can't get DetailViewModel for indexPath - \(indexPath)")
            return
        }
        
        let detailViewController = DetailViewController.instantiate()
        detailViewController.viewModel = detailViewModel
        
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
