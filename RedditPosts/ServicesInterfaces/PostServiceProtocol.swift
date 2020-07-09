//
//  PostServiceInterface.swift
//  ServicesInterfaces
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation

public protocol PostServiceProtocol {
    
    func fetch(after: String, callback: (Result<[[String : Any]], NetworkError>) -> Void)
    
    func fetch(before: String, callback: (Result<[[String : Any]], NetworkError>) -> Void)
    
}

public enum NetworkError: Error {
    case domainError
    case decodingError
}
