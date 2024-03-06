//
//  HomeViewCoordinator.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 11.02.2024.
//

import Foundation
import UIKit

class HomeViewCoordinator: Coordinator {
    func addChildCoordinator(_ coordinator: any Coordinator) {
        //
    }
    
    func removeChildCoordinator(_ coordinator: any Coordinator) {
        //
    }
    
    
    var childCoordinators: [any Coordinator] = []
    
    let rootViewController: UITabBarController
    
    let rootNavigationController: UINavigationController = {
        let navVC = UINavigationController()
        return navVC
    }()
    
    init(rootViewController: UITabBarController) {
            self.rootViewController = rootViewController
        }
    
    func start() {
        let controller = HomeViewController.instantiate(name: .main)
        rootNavigationController.setViewControllers([controller], animated: false)
        
        rootViewController.setViewControllers([rootNavigationController], animated: false)
    }
    
    func finish() {
        
    }
    
    func removeAllChildCoordinators() {
        
    }
    
    func navigateTo(to route: HomeRoute) {
  
    }
    
}
