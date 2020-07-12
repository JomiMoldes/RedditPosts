//
//  PostsSplitViewModelProtocol.swift
//  PostsBrowserFeatureInterfaces
//
//  Created by Miguel Moldes on 12/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import ModelsInterfaces

public protocol PostsSplitViewModelProtocol {
    
    func createBrowserViewModel(shouldSplit: Bool) -> PostsBrowserViewModelProtocol
    
    func createDetailViewModel(post: PostProtocol) -> PostDetailViewModelProtocol
    
}
