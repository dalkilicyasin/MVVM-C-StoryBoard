//
//  AdminPanelViewModel.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 16.03.2024.
//

import Foundation

protocol AdminPanelViewModelDelegate: AnyObject {
    func observedData()
}

class AdminPanelViewModel {
    var adminInfo: UserListResponseModel?
    weak var adminPanelViewModelDelegate: AdminPanelViewModelDelegate?
    
    func callAdminIfo() {
        let url = "\(NetWorkHelper.shared.baseURL)/dalkilicyasin"
        
        NetworkService.shared.request(type: UserListResponseModel.self, url: url, methot: .get) { [weak self] response in
            switch response {
            case .success(let adminData):
                self?.adminInfo = adminData
                self?.adminPanelViewModelDelegate?.observedData()
            case .failure(let error):
                print("\(error.rawValue)")
            }
        }
    }
    
}
