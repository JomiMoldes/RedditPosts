//
//  PostsPaginatorTests.swift
//  ModelsTests
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import ServicesInterfaces
import ModelsInterfaces
import Utils
import XCTest

@testable import Models

class PostsPaginatorTests: XCTestCase {
    
    func test_fetch_latest() {
        
        let service = PostServiceFake()
        service.afterResponse = PostsPaginatorTests.fakedResponse
        let sut = self.createSUT(service: service)
        
        let exp = self.expectation(description: "should fetch latests posts")
        
        sut.fetchLatest { result in
            switch result {
            case .success():
                exp.fulfill()
                break
            case .failure(_):
                XCTFail("should return response")
            }
        }
        
        self.waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            XCTAssertEqual(sut.after, "1")
            XCTAssertEqual(sut.before, "2")
            XCTAssertEqual(sut.results[0].id, "1")
            XCTAssertEqual(sut.results[0].title, "Any title")
            XCTAssertEqual(sut.results[0].thumbnail, "url 1")
            XCTAssertEqual(sut.results[1].id, "2")
            XCTAssertEqual(sut.results[1].title, "Any title 2")
            XCTAssertEqual(sut.results[1].thumbnail, "url 2")
        }
    }
    
    func test_fetch_latest_calls_with_after() {
            
            let service = PostServiceFake()
            service.afterResponse = PostsPaginatorTests.fakedResponse
            let sut = self.createSUT(service: service)
            
            let exp = self.expectation(description: "should fetch latests posts with after")
            
            sut.fetchLatest { result in
                switch result {
                case .success():
                    XCTAssertNil(service.lastAfter)
                    sut.fetchLatest { result in
                        switch result {
                        case .success():
                            XCTAssertEqual(service.lastAfter, "1")
                            exp.fulfill()
                            break
                        case .failure(_):
                            XCTFail("should return response")
                        }
                    }
                    break
                case .failure(_):
                    XCTFail("should return response")
                }
            }
            
            self.waitForExpectations(timeout: 1.0) { error in
                if let error = error {
                    XCTFail(error.localizedDescription)
                }
            }
        }
    
    private func createSUT(service: PostServiceProtocol) -> PostsPaginator {
        let postsCreator = PostsCreatorFake()
        let sut = PostsPaginator(results: [Post](),
                                 before: nil,
                                 after: nil,
                                 service: service,
                                 postsCreator: postsCreator)
        return sut
    }
        
    static let fakedResponse: [String : Any] = [
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



// TO DO: Share Fakes between different modules

class PostServiceFake: PostServiceProtocol {
    
    var afterResponse = [String: Any]()
    var beforeResponse = [String: Any]()
    var lastAfter: String?
    
    func fetch(after: String?, callback: (Result<[String : Any], NetworkError>) -> Void) {
        self.lastAfter = after
        callback(.success(self.afterResponse))
    }
    
    func fetch(before: String?, callback: (Result<[String : Any], NetworkError>) -> Void) {
        callback(.success(self.beforeResponse))
    }
    
}

class PostsCreatorFake: PostsListCreatorProtocol {
    
    func createPost(from json: [String : Any]) -> PostProtocol? {
        let decoder = JSONDecoder()
        var element: PostFake?
        do {
            if let data = try? JSONSerialization.data(withJSONObject: json) {
                element = try? decoder.decode(PostFake.self, from: data)
            }
        }
        return element
    }
    
}

struct PostFake: PostProtocol {
    
    var id: String
    var thumbnail: String
    var title: String
    var createdTime: TimeInterval
    var author: String
    var comments: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, thumbnail, author
        case createdTime = "created_utc"
        case comments = "num_comments"
    }
}
