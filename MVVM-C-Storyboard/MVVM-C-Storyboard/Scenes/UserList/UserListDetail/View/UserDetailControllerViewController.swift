//
//  UserDetailControllerViewController.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 13.03.2024.
//

import UIKit

class UserDetailControllerViewController: UIViewController, Storyboarded {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userTypeLAbel: UILabel!
    
    var viewModel: UserDetailListViewModel
    var coordinator: UserListDetailCoordinator?
    
    public init(viewModel: UserDetailListViewModel, coordinator: UserListDetailCoordinator? = nil){
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = UserDetailListViewModel()
        self.coordinator = UserListDetailCoordinator(navigationController: nil)
       super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Github User Detail"
        DispatchQueue.global(qos: .background).async {
            do
             {
                 let data = try Data.init(contentsOf: URL.init(string:"\(self.viewModel.userListResponseModel?.avatar_url ?? "")")!)
                   DispatchQueue.main.async {
                       let image: UIImage = UIImage(data: data)!
                       self.userImage.image = image
                   }
             }
            catch {
                   // error
                  }
        }
        self.userNameLabel.text = self.viewModel.userListResponseModel?.login ?? ""
        self.userTypeLAbel.text = self.viewModel.userListResponseModel?.type ?? ""
    }
}
