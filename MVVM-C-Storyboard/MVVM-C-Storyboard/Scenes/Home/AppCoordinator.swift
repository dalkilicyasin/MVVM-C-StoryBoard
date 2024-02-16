//
//  AppCoordinator.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 11.02.2024.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [ Coordinator] = []
    
    var navigationController: UINavigationController
   
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {        
        let controller = HomeViewController.instantiate(name: .main)
        controller.coordinator = self
        navigationController.setViewControllers([controller], animated: false)
    }
    
    func finish() {
        
    }
    
    func addChildCoordinator(_ coordinator:  Coordinator) {
        self.childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator:  Coordinator) {
        guard let index = childCoordinators.firstIndex(
            where: { $0 === coordinator }) else {
            print("Child coordinator not found!")
            return
        }
    }
    
    func removeAllChildCoordinators() {
        
    }
    
    func navigateTo(to route: HomeRoute) {
        switch route {
            
        case .second:
            let viewController = SecondViewController.instantiate(name: .main)
            navigationController.present(viewController, animated: true)
        case .third:
            let viewController = ThirdViewController.instantiate(name: .main)
            navigationController.show(viewController, sender: nil)
        }
    }
}



