//
//  DecodableHelperInterfaces.swift
//  UtilsInterfaces
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation

public protocol DecodableHelperProtocol {
    
    func decodeJSON<T: Decodable>(json: [String: Any]) throws -> T?
    
}
