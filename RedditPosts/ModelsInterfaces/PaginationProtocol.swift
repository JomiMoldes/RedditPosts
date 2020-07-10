//
//  PaginationProtocol.swift
//  UtilsInterfaces
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation

public protocol PaginationProtocol: Equatable {

    associatedtype PaginatedElement

    var results: [PaginatedElement] { get set }

    var before: String? { get set }
    
    var after: String? { get set }
    
    mutating func fetchLatest(callback: (Result<Void, NetworkError>) -> Void) 
    
    func fetchOlder(result: (Result<Void, NetworkError>) -> Void)
    
}
