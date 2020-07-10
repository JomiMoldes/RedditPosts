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
    
    public init() {
        
    }

    public func fetch(after: String, callback: (Result<[[String : Any]], NetworkError>) -> Void ) {
        // TO DO: URLSession -> Reddit API
        guard let path = Bundle(for: PostsService.self).path(forResource: "top", ofType: "json") else {
            callback(.failure(.decodingError))
            return
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            guard let jsonResult = jsonObject as? [String: Any],
                let result = jsonResult["data"] as? [String: Any] else {
                    callback(.failure(.decodingError))
                    return
            }
            
            guard let children = result["children"] as? [[String: Any]] else {
                callback(.failure(.decodingError))
                return
            }
            
            callback(.success(children))
        } catch {
            callback(.failure(.decodingError))
        }
    }
    
    public func fetch(before: String, callback: (Result<[[String : Any]], NetworkError>) -> Void) {

    }

}
