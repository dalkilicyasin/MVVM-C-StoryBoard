//
//  Coordinator.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 11.02.2024.
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    func start()
    func navigateTo(to route: HomeRoute)
}

public extension Coordinator {
    func finish(){}
    
    func addChildCoordinator(_ coordinator:  Coordinator) {
        self.childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator:  Coordinator) {
        guard let index = childCoordinators.firstIndex(
            where: { $0 === coordinator }) else {
            print("Child coordinator not found")
            return
        }
    }
    func removeAllChildCoordinators(){}
}
