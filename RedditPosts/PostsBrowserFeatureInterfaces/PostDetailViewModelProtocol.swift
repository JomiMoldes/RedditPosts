//
//  PostDetailViewModelProtocol.swift
//  PostsBrowserFeatureInterfaces
//
//  Created by Miguel Moldes on 12/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit

public protocol PostDetailViewModelProtocol {
    
    var author: String { get }
    
    var didUpdateImage: ((UIImage) -> Void)? { get set }
    
    var title: String { get }
    
    func loadThumbnail()
    
}
