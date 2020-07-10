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

final class PostViewCellViewModel {
    
    private let post: PostProtocol
    
    init(post: PostProtocol) {
        self.post = post
    }
    
    var title: String {
        return self.post.title
    }
}
