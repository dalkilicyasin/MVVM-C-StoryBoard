//
//  UserListViewController.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 15.02.2024.
//

import UIKit

class UserListViewController: UIViewController, Storyboarded {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: UserListViewModel
    var coordinator: UserListCoordinator?
    
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
        self.navigationItem.title = "Github UserList"
        self.viewModel.callUserList()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel.delegate = self
    }
}


extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell") as! UserListTableViewCell
        cell.userNameLabel.text = viewModel.userList[indexPath.row].login
        cell.userTypeLabel.text = viewModel.userList[indexPath.row].type
        DispatchQueue.global(qos: .background).async {
               do
                {
                    let data = try Data.init(contentsOf: URL.init(string:"\(self.viewModel.userList[indexPath.row].avatar_url ?? "")")!)
                      DispatchQueue.main.async {
                          let image: UIImage = UIImage(data: data)!
                          cell.userImage.image = image
                      }
                }
               catch {
                      // error
                     }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell") as! UserListTableViewCell
        coordinator?.navigateTo(to: .toUserDetail, data: nil)
    }
}

extension UserListViewController: UserListControllerDelegate {
    func observerData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

