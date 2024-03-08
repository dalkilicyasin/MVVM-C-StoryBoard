//
//  NetworkManager.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 27.02.2024.
//

import Foundation
import Alamofire



public protocol NetworkManager {
    func request<T: Codable>(type: T.Type, url: String, methot: HTTPMethods, complation: @escaping(Result<T, ErrorTypes>) -> ())
}

public final class NetworkService {
    static let shared = NetworkService()
    
}

extension NetworkService: NetworkManager {
    public func request<T: Codable>(type: T.Type, url: String, methot: HTTPMethods, complation: @escaping (Result<T, ErrorTypes>) -> ()) {
        let session = URLSession.shared
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.httpMethod = methot.rawValue
            
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let _ = error {
                    complation(.failure(.generalError))
                } else if let data = data {
                    self.handleResponse(data: data) { response in
                        complation(response)
                    }
                } else {
                    complation(.failure(.invalidURL))
                }
            }
            
            dataTask.resume()
        }
    }
    
    fileprivate func handleResponse<T: Codable>(data: Data, completion: @escaping(Result<T, ErrorTypes>) -> ()) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.invalidURL))
        }
    }
}
