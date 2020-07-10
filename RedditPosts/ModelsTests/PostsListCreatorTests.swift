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
        XCTAssertEqual(post?.id, "1542")
        XCTAssertEqual(post?.title, "Any title")
        XCTAssertEqual(post?.thumbnail, "http://b.thumbs.redditmedia.com/9N1f7UGKM5fPZydrsgbb4_SUyyLW7A27um1VOygY3LM.jpg")
    }
    
}

func getPostJSON() -> [String: Any] {
    return [
        "id": "1542",
        "title": "Any title",
        "thumbnail": "http://b.thumbs.redditmedia.com/9N1f7UGKM5fPZydrsgbb4_SUyyLW7A27um1VOygY3LM.jpg"
    ]
}
