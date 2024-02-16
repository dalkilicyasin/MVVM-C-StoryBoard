//
//  Coordinator.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 11.02.2024.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    func start()
    func finish()
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator:  Coordinator)
    func removeAllChildCoordinators()
}
