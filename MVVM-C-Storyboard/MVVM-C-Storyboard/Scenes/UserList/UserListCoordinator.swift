//
//  UserListCoordinator.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 5.03.2024.
//

import Foundation
import UIKit

public enum UserListRouter: BaseRoute {
    case toMainList
    case toUserDetail
}

protocol UserListCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: UserListCoordinator)
}

public final class UserListCoordinator: Coordinator {
    weak var userListDelegate: UserListCoordinatorDelegate?
    
    public var childCoordinators: [any Coordinator] = []
    
    var navigationController: UINavigationController?
    
    let networkManager: NetworkManager?
    
    init(navigationController: UINavigationController?, networkManager: NetworkManager?) {
        self.navigationController = navigationController
        self.networkManager = networkManager
    }
    
    public func start() {
        self.navigateTo(to: .toMainList, data: nil)
        self.userListDelegate?.didFinish(from: self)
    }
    
    public func navigateTo(to route: UserListRouter, data: AnyObject?) {
        switch route {
        case .toUserDetail:
            // if let userData = data as? UserListResponseModel {
            //     let viewController = UserDetailControllerViewController.instantiate(name: .main)
            //     viewController.viewModel.userListResponseModel = userData
            //     navigationController?.show(viewController, sender: nil)
            // }
            
            //TODO: Prefer this one for prevent memory leaks
            let userList = UserListDetailCoordinator(navigationController: self.navigationController, data: data)
            userList.userListDetailDelegate = self
            addChildCoordinator(userList)
            userList.start()
            
        case .toMainList:
            let controller = UserListViewController.instantiate(name: .main)
            controller.coordinator = self
            navigationController?.show(controller, sender: nil)
        }
    }
}

extension UserListCoordinator: UserDetailListCoordinatorDelegate {
    func didFinish(from coordinator: UserListDetailCoordinator) {
        removeChildCoordinator(coordinator)
    }
}
