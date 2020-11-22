//
//  PostDetailViewModel.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 12/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import Models
import PostsBrowserFeatureInterfaces
import Utils
import UIKit

public class PostDetailViewModel: PostDetailViewModelProtocol {
    
    public var didUpdateImage: ((UIImage) -> Void)?
    
    public var title: String {
        return self.post.title
    }
    
    public var author: String {
        return post.author
    }
    
    private let post: PostProtocol
    
    private let imageProvider: ImageProviderProtocol
    
    public init(post: PostProtocol,
                imageProvider: ImageProviderProtocol) {
        self.post = post
        self.imageProvider = imageProvider
    }
    
    public func loadThumbnail() {
        _ = self.imageProvider.loadImage(imageURL: self.post.thumbnail) { [weak self] image in
            guard let image = image else {
                return
            }
            self?.didUpdateImage?(image)
        }
    }
    
}
