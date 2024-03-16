//
//  UserListResponseModel.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 6.03.2024.
//

import Foundation

class UserListResponseModel: Codable {
    let login: String? 
    let type: String?
    let avatar_url: String?
    let bio: String?
}
