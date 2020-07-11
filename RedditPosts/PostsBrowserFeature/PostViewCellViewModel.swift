//
//  PostViewCellViewModel.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit
import ModelsInterfaces
import UtilsInterfaces
import PostsBrowserFeatureInterfaces

final class PostViewCellViewModel: PostViewCellViewModelProtocol {
    
    private let post: PostProtocol
    private let imageProvider: ImageProviderProtocol
    
    init(post: PostProtocol,
         imageProvider: ImageProviderProtocol) {
        self.post = post
        self.imageProvider = imageProvider
    }
    
    var title: String {
        return self.post.title
    }
    
    var author: String {
        return self.post.author
    }
    
    var timePassed: String {
        // TO DO: format time
        return "\(self.post.createdTime) + ago"
    }
    
    var comments: String {
        let comments: Int = self.post.comments
        return "\(self.post.comments) \(comments == 1 ? "comment" : "comments")"
    }
    
    var dismissTitle: NSAttributedString {
        let attributted = NSAttributedString(string: "Dismiss Post", attributes: [
            .font: UIFont.systemFont(ofSize: 16.0),
            .foregroundColor: UIColor.white
        ])
        return attributted
    }
    
    var thumbnail: UIImage? = nil
    
    var didUpdateImage: (() -> Void)?
    
    func loadThumbnail() -> URLSessionDataTask? {
        let task = self.imageProvider.loadImage(imageURL: self.post.thumbnail) { image in
            self.thumbnail = image
            self.didUpdateImage?()
        }
        return task
    }
}
