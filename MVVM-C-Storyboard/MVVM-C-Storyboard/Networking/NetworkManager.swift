//
//  NetworkManager.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 27.02.2024.
//

import Foundation
import Alamofire

public protocol NetworkManager {
    func request(url: String, methot: String, complation: @escaping() -> ())
}
