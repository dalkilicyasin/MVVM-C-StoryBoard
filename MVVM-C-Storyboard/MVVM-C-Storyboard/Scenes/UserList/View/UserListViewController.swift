//
//  UserListViewController.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 15.02.2024.
//

import UIKit

class UserListViewController: UIViewController, Storyboarded {
    
    let viewModel: UserListViewModel
    
    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
      self.viewModel = UserListViewModel()
       super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.callUserList()
    }
}


