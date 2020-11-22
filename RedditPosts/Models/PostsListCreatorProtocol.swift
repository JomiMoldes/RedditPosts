//
//  PostsListCreatorProtocol.swift
//  ModelsInterfaces
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation

public protocol PostsListCreatorProtocol {
    
    func createPost(from json: [String: Any]) -> PostProtocol?
    
}
