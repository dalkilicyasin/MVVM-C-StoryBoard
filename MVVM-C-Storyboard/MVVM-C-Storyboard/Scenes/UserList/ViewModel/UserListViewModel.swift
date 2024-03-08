//
//  UserListViewModel.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 26.02.2024.
//

import Foundation

protocol UserListControllerDelegate: AnyObject {
   func observerData()
}

class UserListViewModel {
    var userList: [UserListResponseModel] = []
    weak var delegate: UserListControllerDelegate?
    
    func callUserList() {
        let url = "\(NetWorkHelper.shared.baseURL)"
        
        NetworkService.shared.request(type: [UserListResponseModel].self, url: url, methot: .get) { [weak self] response in
            switch response {
            case .success(let userList):
                self?.userList = userList
                self?.delegate?.observerData()
            case .failure(let error):
                print("\(error.rawValue)")
            }
        }
    }
}
