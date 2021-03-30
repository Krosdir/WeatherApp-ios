//
//  RootCoordinator.swift
//  WeatherApp
//
//  Created by Krosdir on 30.03.2021.
//

import Foundation
import UIKit

class RootCoordinator: Coordinator {
    var rootViewController: UIViewController {
        tabController
    }
    
    var parent: Coordinator?
    
    let window: UIWindow
    
    let tabController: UITabBarController
    
    let tableCoordinator: TableCoordinator
    let mapCoordinator: MapCoordinator
    
    var coordinators: [Coordinator] {
        return [tableCoordinator, mapCoordinator]
    }
    
    init(window: UIWindow) {
        
        tabController = UITabBarController()
        
        tableCoordinator = TableCoordinator()
        
        mapCoordinator = MapCoordinator()
        
        self.window = window
    }
    
    func chilgCoordinatorDidFinish(_ coordinator: Coordinator) {
        
    }
    
    func start() {
        var controllers: [UIViewController] = []
        
        tableCoordinator.parent = self
        let tableViewController = tableCoordinator.rootViewController
        tableViewController.tabBarItem = UITabBarItem(title: "Table", image: nil, selectedImage: nil)
        
        mapCoordinator.parent = self
        let mapViewController = mapCoordinator.rootViewController
        mapViewController.tabBarItem = UITabBarItem(title: "Map", image: nil, selectedImage: nil)
        
        controllers.append(tableViewController)
        controllers.append(mapViewController)
        
        tabController.viewControllers = controllers
        tabController.tabBar.isTranslucent = false
        tabController.selectedIndex = 0
        
        window.rootViewController = tabController
        window.makeKeyAndVisible()
    }
}
