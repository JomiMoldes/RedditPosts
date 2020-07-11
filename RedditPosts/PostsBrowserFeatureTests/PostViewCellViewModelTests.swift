//
//  PostViewCellViewModelTests.swift
//  PostsBrowserFeatureTests
//
//  Created by Miguel Moldes on 11/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import XCTest
import TestingResources

@testable import PostsBrowserFeature

final class PostViewCellViewModelTests: XCTestCase {
    
    func test_should_show_Post_Properties() {
        let post = PostFake.faked()
        let sut = createSUT(post: post)
        XCTAssertEqual(sut.title, post.title)
        XCTAssertEqual(sut.author, post.author)
        XCTAssertEqual(sut.timePassed, "\(post.createdTime) + ago")
        XCTAssertEqual(sut.comments, "1 comment")
        XCTAssertEqual(sut.dismissTitle.string, NSAttributedString(string: "Dismiss Post").string)
        XCTAssertNil(sut.thumbnail)
    }
    
    func test_should_show_singular_comment() {
        let post = PostFake.faked()
        let sut = createSUT(post: post)
        XCTAssertEqual(sut.comments, "1 comment")
    }
    
    func test_should_show_plural_comment() {
        let post = PostFake.faked(comments: 2)
        let sut = createSUT(post: post)
        XCTAssertEqual(sut.comments, "2 comments")
    }
    
    private func createSUT(post: PostFake? = nil) -> PostViewCellViewModel {
        let sut = PostViewCellViewModel(post: post ?? PostFake.faked(),
                                        imageProvider: ImageProviderFake())
        return sut
    }
    
}
