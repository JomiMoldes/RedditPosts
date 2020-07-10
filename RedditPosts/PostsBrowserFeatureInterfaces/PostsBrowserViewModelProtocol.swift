//
//  PostsBrowserViewModelProtocol.swift
//  PostsBrowserFeatureInterfaces
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import ModelsInterfaces

public protocol PostsBrowserViewModelProtocol {
    
    var posts: [PostProtocol] { get }
    var didError: ((NetworkError) -> Void)? { get set }
    var didUpdate: (() -> Void)? { get set }
    
    func fetchPosts()
    
}
