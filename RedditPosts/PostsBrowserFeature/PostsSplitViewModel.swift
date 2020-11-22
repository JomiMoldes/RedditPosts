//
//  PostsSplitViewModel.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 12/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import PostsBrowserFeatureInterfaces
import Utils
import Models

public class PostsSplitViewModel: PostsSplitViewModelProtocol {
    
    private let dateUtils: DateUtilsProtocol
    private let paginator: PostsPaginatorProtocol
    private let imageProvider: ImageProviderProtocol
    
    public init(dateUtils: DateUtilsProtocol,
                paginator: PostsPaginatorProtocol,
                imageProvider: ImageProviderProtocol) {
        self.dateUtils = dateUtils
        self.paginator = paginator
        self.imageProvider = imageProvider
    }
    
    public func createBrowserViewModel(shouldSplit: Bool) -> PostsBrowserViewModelProtocol {
        return PostsBrowserViewModel(paginator: paginator,
                                     imageProvider: self.imageProvider,
                                     firstTime: shouldSplit,
                                     dateUtils: self.dateUtils
        )
    }
    
    public func createDetailViewModel(post: PostProtocol) -> PostDetailViewModelProtocol {
        return PostDetailViewModel(post: post,
                                   imageProvider: self.imageProvider)
    }
    
}
