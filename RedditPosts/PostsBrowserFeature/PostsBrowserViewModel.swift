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
// TO DO: see how to solve PostsPaginator dependency
//import Utils

public class PostsBrowserViewModel: PostsBrowserViewModelProtocol {
    
    public var posts: [PostProtocol] {
        return self.paginator.results
    }
    private let paginator: PostsPaginatorProtocol
    
    public var didError: ((NetworkError) -> Void)?
    public var didUpdate: (() -> Void)?
    
    public init(paginator: PostsPaginatorProtocol) {
        self.paginator = paginator
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
        return PostViewCellViewModel(post: post)
    }
    
}
