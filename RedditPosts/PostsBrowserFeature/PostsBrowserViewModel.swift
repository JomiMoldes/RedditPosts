//
//  PostsBrowserViewModel.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import PostsBrowserFeatureInterfaces
import ModelsInterfaces
import UtilsInterfaces

public class PostsBrowserViewModel: PostsBrowserViewModelProtocol {
    
    public var posts: [PostProtocol] {
        return self.paginator.results
    }
    public var viewModels = [PostViewCellViewModelProtocol]()
    private let paginator: PostsPaginatorProtocol
    private let imageProvider: ImageProviderProtocol
    
    public var didError: ((NetworkError) -> Void)?
    public var didUpdate: (() -> Void)?
    
    public init(paginator: PostsPaginatorProtocol,
                imageProvider: ImageProviderProtocol) {
        self.paginator = paginator
        self.imageProvider = imageProvider
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
        let viewModel = PostViewCellViewModel(post: post, imageProvider: self.imageProvider)
        self.viewModels.append(viewModel)
        return viewModel
    }
    
}
