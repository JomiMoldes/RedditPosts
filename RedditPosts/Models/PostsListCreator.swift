//
//  PostsListCreator.swift
//  Models
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation

public class PostsListCreator: PostsListCreatorProtocol {
    
    private let decodableHelper: DecodableHelperProtocol
    
    public init(decodableHelper: DecodableHelperProtocol) {
        self.decodableHelper = decodableHelper
    }
    
    public func createPost(from json: [String : Any]) -> PostProtocol? {
        let post: Post? = try? self.decodableHelper.decodeJSON(json: json)
        return post
    }
    
}
