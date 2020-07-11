//
//  PostsPaginatorFake.swift
//  TestingResources
//
//  Created by Miguel Moldes on 11/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import ModelsInterfaces

public class PostsPaginatorFake: PostsPaginatorProtocol {
    
    public var results: [PostProtocol] = [PostProtocol]()
    
    public var before: String?
    
    public var after: String?
    
    public init(results: [PostProtocol]) {
        self.results = results
    }
    
    public func fetchLatest(callback: @escaping (Result<Void, NetworkError>) -> Void) {
        callback(.success(()))
    }
    
    public func fetchOlder(result: @escaping (Result<Void, NetworkError>) -> Void) {
        
    }
    
}
