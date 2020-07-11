//
//  PostTests.swift
//  PostTests
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import XCTest
import Utils
import TestingResources

@testable import Models

class PostTests: XCTestCase {
    
    func test_Decode() {
        
        do {
            let post: Post? = try DecodableHelper().decodeJSON(json: PostFake.getPostJSON())
            XCTAssertEqual(post?.id, "1")
            XCTAssertEqual(post?.title, "Any title")
            XCTAssertEqual(post?.thumbnail, "url 1")
            XCTAssertEqual(post?.createdTime, 1234)
            XCTAssertEqual(post?.comments, 1)
            XCTAssertEqual(post?.author, "Author 1")
        } catch let error {
            XCTFail("failed decoding \(error.localizedDescription)")
        }
        
    }

}
