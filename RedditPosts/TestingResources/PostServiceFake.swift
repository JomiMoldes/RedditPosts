//
//  PostServiceFake.swift
//  TestingResources
//
//  Created by Miguel Moldes on 11/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import ServicesInterfaces
import ModelsInterfaces

public class PostServiceFake: PostServiceProtocol {
    
    public var afterResponse = [String: Any]()
    public var beforeResponse = [String: Any]()
    public var lastAfter: String?
    
    public init() { }
    
    public func fetch(after: String?, callback: (Result<[String : Any], NetworkError>) -> Void) {
        self.lastAfter = after
        callback(.success(self.afterResponse))
    }
    
    public func fetch(before: String?, callback: (Result<[String : Any], NetworkError>) -> Void) {
        callback(.success(self.beforeResponse))
    }
    
    public static let fakedResponse: [String : Any] = [
        "after": "1",
        "before": "2",
        "children": [
            [
                "data": [
                    "id": "1",
                    "title": "Any title",
                    "thumbnail": "url 1",
                    "created_utc": 1234,
                    "num_comments": 1,
                    "author": "Author 1"
                ]
            ],
            [
                "data": [
                    "id": "2",
                    "title": "Any title 2",
                    "thumbnail": "url 2",
                    "created_utc": 1234,
                    "num_comments": 2,
                    "author": "Author 2"
                ]
            ],
            [
                "data": [
                    "id": "2",
                    "title": "Any title 3",
                    "thumbnail": "url 3",
                    "created_utc": 1234,
                    "num_comments": 3,
                    "author": "Author 3"
                ]
            ],
            [
                "data": [
                    "id": "4",
                    "title": "Any title 4",
                    "thumbnail": "url 4",
                    "created_utc": 1234,
                    "num_comments": 4,
                    "author": "Author 4"
                ]
            ]
        ]
    ]
}
