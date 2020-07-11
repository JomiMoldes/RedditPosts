//
//  PostFake.swift
//  TestingResources
//
//  Created by Miguel Moldes on 11/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import ModelsInterfaces

public struct PostFake: PostProtocol {
    
    public var id: String
    public var thumbnail: String
    public var title: String
    public var createdTime: TimeInterval
    public var author: String
    public var comments: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, thumbnail, author
        case createdTime = "created_utc"
        case comments = "num_comments"
    }
    
    public static func faked(id: String = "1",
                             thumbnail: String = "url 1",
                             title: String = "Any title 1",
                             createdTime: TimeInterval = 124,
                             author: String = "Any author",
                             comments: Int = 1) -> PostFake {
        return PostFake(id: id,
                        thumbnail: thumbnail,
                        title: title,
                        createdTime: createdTime,
                        author: author,
                        comments: comments)
    }
    
    public static func getPostJSON() -> [String: Any] {
        return [
            "id": "1",
            "title": "Any title",
            "thumbnail": "url 1",
            "created_utc": 1234,
            "num_comments": 1,
            "author": "Author 1"
        ]
    }
}

public class PostsCreatorFake: PostsListCreatorProtocol {
    
    public init() { }
    
    public func createPost(from json: [String : Any]) -> PostProtocol? {
        let decoder = JSONDecoder()
        var element: PostFake?
        do {
            if let data = try? JSONSerialization.data(withJSONObject: json) {
                element = try? decoder.decode(PostFake.self, from: data)
            }
        }
        return element
    }
    
}
