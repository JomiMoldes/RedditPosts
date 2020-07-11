//
//  PostProtocol.swift
//  ModelsInterfaces
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation

public protocol PostProtocol: Codable {
    
    var id: String { get }
    var thumbnail: String { get }
    var title: String { get }
    var createdTime: TimeInterval { get }
    var author: String { get }
    var comments: Int { get }
}
