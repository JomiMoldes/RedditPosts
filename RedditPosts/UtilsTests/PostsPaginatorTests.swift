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
        let response = [
            [
                "id": "1",
                "title": "Any title",
                "thumbnail": "url 1"
            ],
            [
                "id": "2",
                "title": "Any title 2",
                "thumbnail": "url 2"
            ]
        ]
        let service = PostServiceFake()
        let postsCreator = PostsCreatorFake()
        service.afterResponse = response
        var sut = PostsPaginator(results: [Post](),
                                 before: nil,
                                 after: nil,
                                 service: service,
                                 postsCreator: postsCreator)
        
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
            XCTAssertEqual(sut.results[0].id, "1")
            XCTAssertEqual(sut.results[0].title, "Any title")
            XCTAssertEqual(sut.results[0].thumbnail, "url 1")
            XCTAssertEqual(sut.results[1].id, "2")
            XCTAssertEqual(sut.results[1].title, "Any title 2")
            XCTAssertEqual(sut.results[1].thumbnail, "url 2")
        }
    }
    
}

// TO DO: Share Fakes between different modules

class PostServiceFake: PostServiceProtocol {
    
    var afterResponse = [[String: Any]]()
    var beforeResponse = [[String: Any]]()
    
    func fetch(after: String, callback: (Result<[[String : Any]], NetworkError>) -> Void) {
        callback(.success(self.afterResponse))
    }
    
    func fetch(before: String, callback: (Result<[[String : Any]], NetworkError>) -> Void) {
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
    
}
