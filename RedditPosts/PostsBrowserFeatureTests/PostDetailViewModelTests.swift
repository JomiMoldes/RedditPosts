//
//  PostDetailViewModelTests.swift
//  PostsBrowserFeatureTests
//
//  Created by Miguel Moldes on 12/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import XCTest
import TestingResources
import ModelsInterfaces

@testable import PostsBrowserFeature

final class PostDetailViewModelTests: XCTestCase {
    
    func test_should_return_post_details() {
        let post = PostFake.faked(author: "Michael")
        let imageProvider = ImageProviderFake()
        let sut = PostDetailViewModel(post: post,
                                      imageProvider: imageProvider)
        XCTAssertEqual(post.author, sut.author)
    }
    
}
