//
//  .swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 16.03.2024.
//

import Foundation
import UIKit

public enum AdminPanelRouter: BaseRoute {
    case toMain
}

protocol AdminPanelCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: AdminPanelCoordinator)
}

class AdminPanelCoordinator: Coordinator {

    var navigationController: UINavigationController?
    
    weak var adminPanelCoordinatorDelegate: AdminPanelCoordinatorDelegate?
   
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    var childCoordinators: [any Coordinator] = []
    
    func start() {
        self.navigateTo(to: .toMain, data: nil)
        self.adminPanelCoordinatorDelegate?.didFinish(from: self)
    }
    
    func navigateTo(to route: AdminPanelRouter, data: AnyObject?) {
        switch route {
        case .toMain:
            let controller = AdminPanelViewController.instantiate(name: .main)
            self.navigationController?.show(controller, sender: nil)
        }
    }
}
