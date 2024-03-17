//
//  NetworkManager.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 27.02.2024.
//

import Foundation
import Alamofire

public protocol NetworkManager {
    func request<T: Codable>(type: T.Type, url: String, methot: HTTPMethod, complation: @escaping(Result<T, ErrorTypes>) -> ())
}

public final class NetworkService {
    static let shared = NetworkService()
    
}

extension NetworkService: NetworkManager {
    public func request<T: Codable>(type: T.Type, url: String, methot: HTTPMethod, complation: @escaping (Result<T, ErrorTypes>) -> ()) {
        
     //MARK: For URLSessions;
      //  let session = URLSession.shared
      //  if let url = URL(string: url) {
      //      var request = URLRequest(url: url)
      //      request.httpMethod = methot.rawValue
      //
      //      let dataTask = session.dataTask(with: request) { data, response, error in
      //          if let _ = error {
      //              complation(.failure(.generalError))
      //          } else if let data = data {
      //              self.handleResponse(data: data) { response in
      //                  complation(response)
      //              }
      //          } else {
      //              complation(.failure(.invalidURL))
      //          }
      //      }
      //
      //      dataTask.resume()
      //  }
        
        //MARK: For Alamofire.
        ///It can be used AF methot for parsing. In the other hand you can use handleResponse func for parse.
        AF.request(url, method: methot).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                complation(.success(data))
            case .failure(_):
                complation(.failure(.generalError))
            }
        }
        /// This methot " AF.request.responseData " can be use for your own parse methot
        //AF.request(url, method: methot).responseData { response in
        //    switch response.result {
        //    case .success(let data):
        //        self.handleResponse(data: data) { response in
        //            complation(response)
        //        }
        //    case .failure(_):
        //        complation(.failure(.generalError))
        //    }
        //}
        
    }
    //MARK: For URL Session and Alamofire
    fileprivate func handleResponse<T: Codable>(data: Data, completion: @escaping(Result<T, ErrorTypes>) -> ()) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.invalidURL))
        }
    }
}
