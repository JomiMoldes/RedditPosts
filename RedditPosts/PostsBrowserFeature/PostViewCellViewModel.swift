//
//  PostViewCellViewModel.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit
import Models
import Utils
import PostsBrowserFeatureInterfaces

final class PostViewCellViewModel: PostViewCellViewModelProtocol {
    
    private var post: PostProtocol
    private let imageProvider: ImageProviderProtocol
    private let dateUtils: DateUtilsProtocol
    
    init(post: PostProtocol,
         imageProvider: ImageProviderProtocol,
         dateUtils: DateUtilsProtocol) {
        self.post = post
        self.imageProvider = imageProvider
        self.dateUtils = dateUtils
    }
    
    var title: String {
        return self.post.title
    }
    
    var id: String {
        return self.post.id
    }
    
    var author: String {
        return self.post.author
    }
    
    var timePassed: String {
        // TO DO: format time
        let now = Date()
        let from = Date(timeIntervalSince1970: self.post.createdTime)
        let timeElapsed = self.dateUtils.timeElapsed(from: from, to: now)
        return "\(timeElapsed) + ago"
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
    
    var didUpdateInfo: (() -> Void)?
    
    func loadThumbnail() -> URLSessionDataTask? {
        let task = self.imageProvider.loadImage(imageURL: self.post.thumbnail) { image in
            self.thumbnail = image
            self.didUpdateImage?()
        }
        return task
    }
    
    var read: Bool {
        get {
            return self.post.read
        }
    }
    
    func selected() {
        self.post.read = true
        self.didUpdateInfo?()
    }
}
