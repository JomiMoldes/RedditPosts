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
import TestingResources

@testable import Models

class PostsPaginatorTests: XCTestCase {
    
    func test_fetch_latest() {
        
        let service = PostServiceFake()
        service.afterResponse = PostServiceFake.fakedResponse
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
            service.afterResponse = PostServiceFake.fakedResponse
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

}
