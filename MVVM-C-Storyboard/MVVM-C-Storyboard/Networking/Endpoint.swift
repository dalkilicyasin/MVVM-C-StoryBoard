//
//  Endpoint.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 5.03.2024.
//

import Foundation
import Alamofire

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public class Endpoint<R: Decodable>: Requestable {
    public let path: String
    public let method: RequestMethod
    public let headerParameters: [String: String]
    public let queryParams: Encodable?
    public let bodyParams: Encodable?

    public init(path: String,
                method: RequestMethod,
                headerParameters: [String: String] = [:],
                queryParams: Encodable? = nil,
                bodyParams: Encodable? = nil) {
        self.path = path
        self.method = method
        self.headerParameters = headerParameters
        self.queryParams = queryParams
        self.bodyParams = bodyParams
    }
}
