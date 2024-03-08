//
//  Endpoint.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 5.03.2024.
//

import Foundation
import Alamofire


public enum ErrorTypes: String, Error {
    case invalidData = "Invalid Data"
    case invalidURL = "Invalid URL"
    case generalError = "An Error Happened"
}

public enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

class NetWorkHelper {
    static let shared = NetWorkHelper()
    let baseURL = "https://api.github.com/users"
    let header = ["Auth" : "Bearer"]
    
    func saveToken(token: String) {
        
    }
}
