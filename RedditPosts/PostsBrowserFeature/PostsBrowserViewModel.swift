//
//  PostsBrowserViewModel.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import PostsBrowserFeatureInterfaces
import Models
import Utils

public class PostsBrowserViewModel: PostsBrowserViewModelProtocol {
    
    public var posts: [PostProtocol] {
        return self.paginator.results
    }
    public var viewModels = [PostViewCellViewModelProtocol]()
    private let paginator: PostsPaginatorProtocol
    private let imageProvider: ImageProviderProtocol
    
    public var didError: ((NetworkError) -> Void)?
    public var didUpdate: (() -> Void)?
    
    public var firstTime: Bool
    private let dateUtils: DateUtilsProtocol
    public var lastSelectedIndex: Int = 0
    
    public let title: String = "Reddit Posts"
    
    public init(paginator: PostsPaginatorProtocol,
                imageProvider: ImageProviderProtocol,
                firstTime: Bool,
                dateUtils: DateUtilsProtocol) {
        self.paginator = paginator
        self.imageProvider = imageProvider
        self.firstTime = firstTime
        self.dateUtils = dateUtils
    }
    
    public func fetchPosts() {
        self.paginator.fetchLatest() { result in
            switch result {
            case .success(_):
                self.didUpdate?()
                break
            case .failure(let error):
                self.didError?(error)
            }
        }
    }
    
    public func createViewCellModel(post: PostProtocol) -> PostViewCellViewModelProtocol {
        if let viewModel = self.viewModels.first(where: { post.id == $0.id }) {
            return viewModel
        }
        let viewModel = PostViewCellViewModel(post: post,
                                              imageProvider: self.imageProvider,
                                              dateUtils: self.dateUtils)
        self.viewModels.append(viewModel)
        return viewModel
    }
    
    public func removePost(at index: Int) {
        guard self.posts.count > index &&
            self.viewModels.count > index else {
            return
        }
        self.paginator.removePost(at: index)
        self.viewModels.remove(at: index)
        self.didUpdate?()
    }
    
}
