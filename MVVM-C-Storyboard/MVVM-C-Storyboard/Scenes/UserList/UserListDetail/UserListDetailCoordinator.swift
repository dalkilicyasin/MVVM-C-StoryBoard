//
//  UserListDetailCoordinator.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 13.03.2024.
//

import Foundation
import UIKit

protocol UserDetailListCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: UserListDetailCoordinator)
}

public final class UserListDetailCoordinator: Coordinator {
    
    public var childCoordinators: [any Coordinator] = []
    weak var userListDetailDelegate: UserDetailListCoordinatorDelegate?
    var navigationController: UINavigationController?
    let data: AnyObject?
   
    init(navigationController: UINavigationController?, data: AnyObject?) {
        self.navigationController = navigationController
        self.data = data
    }
    
    public func start() {
        self.navigateTo(to: .toUserDetail, data: self.data)
        self.userListDetailDelegate?.didFinish(from: self)
    }
    
    public func navigateTo(to route: UserListRouter, data: AnyObject?) {
        switch route {
        case .toUserDetail:
           // let viewController = UserDetailControllerViewController.instantiate(name: .main)
           // navigationController?.show(viewController, sender: nil)
             if let userData = data as? UserListResponseModel {
                 let viewController = UserDetailControllerViewController.instantiate(name: .main)
                 viewController.viewModel.userListResponseModel = userData
                 navigationController?.show(viewController, sender: nil)
             }
        case .toMainList:
            break
        }
       
    }
}
