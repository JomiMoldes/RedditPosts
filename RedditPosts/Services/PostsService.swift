//
//  PostsService.swift
//  Services
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import ServicesInterfaces
import ModelsInterfaces

public class PostsService: PostServiceProtocol {
    
    private var token: String?
    
    private static let base_url = "https://www.reddit.com/"
    private static let access_token = base_url + "api/v1/access_token"
    
    private static let client_id = "iJpjMjlqOB8pjg"
    private let deviceId: String
    
    public init(token: String? = nil, deviceId: String) {
        self.token = token
        self.deviceId = deviceId
    }
    
    private func fetchToken(callback: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: PostsService.access_token) else {
            callback(.failure(.domainError))
            return
        }
        
        let session = URLSession.shared
        let loginString = "\(PostsService.client_id):"
        guard let loginData: Data = loginString.data(using: .utf8) else {
            callback(.failure(.domainError))
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let requestHeaders: [String: String] = [
            "Authorization": "Basic \(base64LoginString)",
            "User-Agent": "MiguelMoldesRedditTests",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        request.allHTTPHeaderFields = requestHeaders
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "https://oauth.reddit.com/grants/installed_client&device_id=\(self.deviceId)")
        ]
        
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonDic = json as? [String: Any],
                    let access_token = jsonDic["access_token"] as? String {
                    callback(.success(access_token))
                    return
                }
                callback(.failure(.decodingError))
            } catch {
                callback(.failure(.decodingError))
            }
        }
        task.resume()
    }

    public func fetch(after: String, callback: @escaping (Result<[[String : Any]], NetworkError>) -> Void ) {
        guard let access_token = self.token else {
            self.fetchToken() { result in
                switch result {
                case .success(let token):
                    self.token = token
                    self.fetch(after: after, callback: callback)
                case .failure(let error):
                    callback(.failure(error))
                }
            }
            return
        }
        print(access_token)
    }
//    public func fetch(after: String, callback: (Result<[[String : Any]], NetworkError>) -> Void ) {

//        guard let path = Bundle(for: PostsService.self).path(forResource: "top", ofType: "json") else {
//            callback(.failure(.decodingError))
//            return
//        }
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//            guard let jsonResult = jsonObject as? [String: Any],
//                let result = jsonResult["data"] as? [String: Any] else {
//                    callback(.failure(.decodingError))
//                    return
//            }
//
//            guard let children = result["children"] as? [[String: Any]] else {
//                callback(.failure(.decodingError))
//                return
//            }
//
//            callback(.success(children))
//        } catch {
//            callback(.failure(.decodingError))
//        }
//    }
    
    public func fetch(before: String, callback: (Result<[[String : Any]], NetworkError>) -> Void) {

    }

}
