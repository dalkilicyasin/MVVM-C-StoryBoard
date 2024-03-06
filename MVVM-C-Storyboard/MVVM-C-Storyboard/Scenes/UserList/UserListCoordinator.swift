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

protocol UserListDelegate: AnyObject {
    func didFinish(from coordinator: UserListCoordinator)
}


public final class UserListCoordinator: Coordinator {
    weak var userListDelegate: UserListDelegate?

    public var childCoordinators: [any Coordinator] = []
    
    var navigationController: UINavigationController
   
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        navigateTo(to: .toUserDetail)
        self.userListDelegate?.didFinish(from: self)
    }
    
    public func navigateTo(to route: UserListRouter) {
        switch route {
        case .toUserDetail:
            print("toDetail")
        case .toMainList:
            print("toMainList")
        }
    }
    
}
