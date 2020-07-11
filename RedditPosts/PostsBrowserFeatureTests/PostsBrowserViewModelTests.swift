//
//  PostsBrowserViewModelTests.swift
//  PostsBrowserFeatureTests
//
//  Created by Miguel Moldes on 11/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import TestingResources
import ModelsInterfaces
import XCTest

@testable import PostsBrowserFeature

final class PostsBrowserViewModelTests: XCTestCase {
    
    func test_should_have_paginator_results() {
        let paginator = createPaginator()
        let sut = createSUT(paginator)
        XCTAssertEqual(sut.posts.count, paginator.results.count)
    }
    
    func test_should_fetch_posts_and_notify() {
        let sut = createSUT()
        
        let exp = self.expectation(description: "should fetch posts")
        sut.didUpdate = {
            exp.fulfill()
        }
        
        sut.fetchPosts()
        
        self.waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func test_should_create_post_view_model() {
        let sut = createSUT()
        let post = PostFake.faked(title: "Post title")
        let postViewModel = sut.createViewCellModel(post: post)
        XCTAssertEqual(postViewModel.title, "Post title")
    }
    
    private func createPaginator() -> PostsPaginatorProtocol {
        let posts = [PostFake.faked(id: "1"), PostFake.faked(id: "2"), PostFake.faked(id: "3")]
        let paginator: PostsPaginatorProtocol = PostsPaginatorFake(results: posts)
        return paginator
    }
    
    private func createSUT(_ paginator: PostsPaginatorProtocol? = nil) -> PostsBrowserViewModel {
        
        let sut = PostsBrowserViewModel(paginator: paginator ?? createPaginator())
        return sut
    }
    
}
