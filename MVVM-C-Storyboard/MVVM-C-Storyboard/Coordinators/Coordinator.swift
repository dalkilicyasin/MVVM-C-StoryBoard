//
//  Coordinator.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 11.02.2024.
//

import Foundation
import UIKit

public protocol BaseRoute{
}

public protocol Coordinator: AnyObject {
    associatedtype Route: BaseRoute
    var childCoordinators: [any Coordinator] {get set}
    func start()
    func navigateTo(to route: Route, data: AnyObject?)
}

public extension Coordinator {
    func finish(){}
    
    func addChildCoordinator(_ coordinator:  any Coordinator) {
        self.childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator:  any Coordinator) {
        guard let index = childCoordinators.firstIndex(
            where: { $0 === coordinator }) else {
            print("Child coordinator not found")
            return
        }
    }
    func removeAllChildCoordinators(){}
}
