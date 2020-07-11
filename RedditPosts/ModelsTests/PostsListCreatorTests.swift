//
//  PostsListCreatorTests.swift
//  ModelsTests
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import ModelsInterfaces
import XCTest

@testable import Models

class PostsListCreatorTests: XCTestCase {
    
    func test_CreatePosts() {
        let sut = PostsListCreator(decodableHelper: DecodableHelper())
        let post = sut.createPost(from: getPostJSON())
        XCTAssertEqual(post?.id, "1")
        XCTAssertEqual(post?.title, "Any title")
        XCTAssertEqual(post?.thumbnail, "url 1")
        XCTAssertEqual(post?.createdTime, 1234)
        XCTAssertEqual(post?.comments, 1)
        XCTAssertEqual(post?.author, "Author 1")
    }
    
}

func getPostJSON() -> [String: Any] {
    return [
        "id": "1",
        "title": "Any title",
        "thumbnail": "url 1",
        "created_utc": 1234,
        "num_comments": 1,
        "author": "Author 1"
    ]
}
