//
//  Post.swift
//  Models
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import ModelsInterfaces

public struct Post: PostProtocol {
    public var id: String
    public var title: String
    public var thumbnail: String
}
