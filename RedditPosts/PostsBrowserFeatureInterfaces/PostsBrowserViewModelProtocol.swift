//
//  PostsBrowserViewModelProtocol.swift
//  PostsBrowserFeatureInterfaces
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import ModelsInterfaces
import UIKit

public protocol PostsBrowserViewModelProtocol {
    
    var posts: [PostProtocol] { get }
    var viewModels: [PostViewCellViewModelProtocol] { get }
    var didError: ((NetworkError) -> Void)? { get set }
    var didUpdate: (() -> Void)? { get set }
    var firstTime: Bool { get set }
    var lastSelectedIndex: Int { get set }
    
    func fetchPosts()
    
    func createViewCellModel(post: PostProtocol) -> PostViewCellViewModelProtocol
    
    func removePost(at index: Int)
    
}

public protocol PostViewCellViewModelProtocol {
    
    var id: String { get }
    
    var title: String { get }
    
    var author: String { get }
    
    var timePassed: String { get }
    
    var comments: String { get }
    
    var thumbnail: UIImage? { get }
    
    var didUpdateImage: (() -> Void)? { get set}
    
    var didUpdateInfo: (() -> Void)? { get set}
    
    var dismissTitle: NSAttributedString { get }
    
    func loadThumbnail() -> URLSessionDataTask?
    
    var read: Bool { get }
    
    func selected()
    
}
