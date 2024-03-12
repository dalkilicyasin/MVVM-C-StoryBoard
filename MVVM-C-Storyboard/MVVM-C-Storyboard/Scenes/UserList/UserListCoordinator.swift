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
        navigateTo(to: .toMainList, data: nil)
        self.userListDelegate?.didFinish(from: self)
    }
    
    public func navigateTo(to route: UserListRouter, data: AnyObject?) {
        switch route {
        case .toUserDetail:
            if let userData = data as? UserListResponseModel {
                print("\(userData.login ?? "")")
            }
        case .toMainList:
            let viewController = UserListViewController.instantiate(name: .main)
            navigationController?.show(viewController, sender: nil)
        }
    }
}
