//
//  Post.swift
//  Models
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation

public struct Post: PostProtocol {
    public var id: String
    public var title: String
    public var thumbnail: String
    public var createdTime: TimeInterval
    public var author: String
    public var comments: Int
    public var read: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, title, thumbnail, author
        case createdTime = "created_utc"
        case comments = "num_comments"
    }
    
}
