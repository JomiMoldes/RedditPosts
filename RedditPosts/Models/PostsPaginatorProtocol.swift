//
//  PostsPaginatorProtocol.swift
//  UtilsInterfaces
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation

public protocol PostsPaginatorProtocol {

    var results: [PostProtocol] { get set }

    var before: String? { get set }
    
    var after: String? { get set }
    
    // TO DO: split this responsiblity in another object
    
    func fetchLatest(callback: @escaping (Result<Void, NetworkError>) -> Void)
    
    func fetchOlder(result: @escaping (Result<Void, NetworkError>) -> Void)
    
    func removePost(at index: Int)
    
}
