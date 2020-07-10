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

@testable import PostsBrowserFeature

class PostBrowserViewControllerTests: XCTestCase {
    
    func test_should_call_to_fetch_when_it_starts() {
        let viewModel = self.createViewModel()
        let sut = self.createSUT(viewModel: viewModel)
        _ = sut.view
        XCTAssertTrue(viewModel.fetched)
    }
    
    func test_should_show_posts_in_table() {
        let sut = self.createSUT()
        _ = sut.view
        guard let table: UITableView = sut.view.subviews.first(where: { $0 is UITableView}) as? UITableView else {
            XCTFail("should have a table")
            return
        }
        XCTAssertEqual(table.numberOfRows(inSection: 0), 1)
    }
    
    // TO DO: test has a loader
    
}

private extension PostBrowserViewControllerTests {
    
    func createViewModel() -> PostsBrowserViewModelFake {
        let posts = [PostFake(id: "1", thumbnail: "th", title: "Title")]
        let paginator = Paginator(results: posts)
        let vModel = PostsBrowserViewModelFake(paginator: paginator)
        return vModel
    }
    
    func createSUT(viewModel: PostsBrowserViewModel? = nil) -> PostsBrowserViewController {
        let posts = [PostFake(id: "1", thumbnail: "th", title: "Title")]
        let paginator = Paginator(results: posts)
        let vModel = viewModel ?? PostsBrowserViewModelFake(paginator: paginator)
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

class Paginator: PostsPaginatorProtocol {
    var results: [PostProtocol] = [PostProtocol]()
    
    var before: String?
    
    var after: String?
    
    init(results: [PostProtocol]) {
        self.results = results
    }
    
    func fetchLatest(callback: @escaping (Result<Void, NetworkError>) -> Void) {
        
    }
    
    func fetchOlder(result: @escaping (Result<Void, NetworkError>) -> Void) {
        
    }
    
}

struct PostFake: PostProtocol {
    
    var id: String
    
    var thumbnail: String
    
    var title: String
    
}
