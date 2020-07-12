//
//  PostBrowserViewControllerTests.swift
//  PostsBrowserFeatureTests
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import XCTest
import ModelsInterfaces
import TestingResources

@testable import PostsBrowserFeature

class PostBrowserViewControllerTests: XCTestCase {
    
    weak var weakSUT: PostsBrowserViewController?
    
    override func tearDown() {
        super.tearDown()
        XCTAssertNil(self.weakSUT)
    }
    
    func testMemoryLeak() {
        let controller = self.createSUT()
        _ = controller.view
        
        self.weakSUT = controller
    }
    
    func test_should_call_to_fetch_when_it_starts() {
        let viewModel = self.createViewModel()
        let sut = self.createSUT(viewModel: viewModel)
        _ = sut.view
        XCTAssertTrue(viewModel.fetched)
    }
    
    func test_should_show_posts_in_table() {
        let viewModel = self.createViewModel()
        let sut = self.createSUT(viewModel: viewModel)
        _ = sut.view
        XCTAssertTrue(viewModel.firstTime)
        guard let table: UITableView = sut.view.subviews.first(where: { $0 is UITableView}) as? UITableView else {
            XCTFail("should have a table")
            return
        }
        XCTAssertEqual(table.numberOfRows(inSection: 0), 1)

        _ = sut.tableView(table, cellForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertFalse(viewModel.firstTime)
    }
    
    // TO DO: test has a loader
    
}

private extension PostBrowserViewControllerTests {
    
    func createViewModel() -> PostsBrowserViewModelFake {
        let posts = [PostFake.faked()]
        let paginator = PostsPaginatorFake(results: posts)
        let vModel = PostsBrowserViewModelFake(paginator: paginator,
                                               imageProvider: ImageProviderFake())
        return vModel
    }
    
    func createSUT(viewModel: PostsBrowserViewModel? = nil) -> PostsBrowserViewController {
        let posts = [PostFake.faked()]
        let paginator = PostsPaginatorFake(results: posts)
        let vModel = viewModel ?? PostsBrowserViewModelFake(paginator: paginator,
                                                            imageProvider: ImageProviderFake())
        let sut = PostsBrowserViewController(viewModel: vModel)
        return sut
    }
    
}

private class PostsBrowserViewModelFake: PostsBrowserViewModel {
    
    var fetched: Bool = false
    
    override func fetchPosts() {
        self.fetched = true
    }
    
}
