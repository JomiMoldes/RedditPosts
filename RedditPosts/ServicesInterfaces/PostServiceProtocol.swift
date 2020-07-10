//
//  PostServiceInterface.swift
//  ServicesInterfaces
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import ModelsInterfaces

public protocol PostServiceProtocol {
    
    func fetch(after: String, callback: @escaping (Result<[[String : Any]], NetworkError>) -> Void)
    
    func fetch(before: String, callback: @escaping (Result<[[String : Any]], NetworkError>) -> Void)
    
}
