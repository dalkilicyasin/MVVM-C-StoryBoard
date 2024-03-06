//
//  AppCoordinator.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 11.02.2024.
//

import Foundation
import UIKit

public enum HomeRoute: BaseRoute {
    case second
    case third
}

class AppCoordinator: Coordinator {

    var childCoordinators: [ any Coordinator] = []
    
    var navigationController: UINavigationController
   
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {        
        let controller = HomeViewController.instantiate(name: .main)
        controller.coordinator = self
        navigationController.setViewControllers([controller], animated: false)
    }
    
    func navigateTo(to route: HomeRoute) {
        switch route {
        case .second:
            //let viewController = UserListViewController.instantiate(name: .main)
            //navigationController.show(viewController, sender: nil)
            let userList = UserListCoordinator(navigationController: self.navigationController)
            userList.userListDelegate = self
            addChildCoordinator(userList)
            userList.start()
            
        case .third:
            let viewController = ThirdViewController.instantiate(name: .main)
            navigationController.show(viewController, sender: nil)
        }
    }
}

extension AppCoordinator: UserListDelegate {
    func didFinish(from coordinator: UserListCoordinator) {
        removeChildCoordinator(coordinator)
    }
}



