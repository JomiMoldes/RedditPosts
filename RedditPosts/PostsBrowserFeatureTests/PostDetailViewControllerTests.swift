//
//  PostDetailViewControllerTests.swift
//  PostsBrowserFeatureTests
//
//  Created by Miguel Moldes on 12/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import XCTest
import TestingResources

@testable import PostsBrowserFeature

final class PostDetailViewControllerTests: XCTestCase {
    
    private weak var weakSUT: PostDetailViewController?
    
    override func tearDown() {
        super.tearDown()
        XCTAssertNil(self.weakSUT)
    }
    
    func test_memory_leaks() {
        let sut = self.createSUT()
        _ = sut.view
        self.weakSUT = sut
    }
    
    func test_shows_Post_details() {
        let sut = self.createSUT()
        let view: PostDetailView? = sut.view as? PostDetailView
        XCTAssertEqual(view?.authorLabel.text, "Michael")
    }
    
    private func createSUT() -> PostDetailViewController {
        let post = PostFake.faked(author: "Michael")
        let imageProvider = ImageProviderFake()
        let viewModel = PostDetailViewModel(post: post, imageProvider: imageProvider)
        let sut = PostDetailViewController(viewModel: viewModel)
        return sut
    }
    
}
