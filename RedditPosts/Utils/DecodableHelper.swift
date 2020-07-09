//
//  DecodableHelper.swift
//  Utils
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UtilsInterfaces

public class DecodableHelper: DecodableHelperProtocol {
    
    public init() { }
    
    public func decodeJSON<T: Decodable>(json: [String: Any]) throws -> T? {
        let decoder = JSONDecoder()
        var element: T?
        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            element = try decoder.decode(T.self, from: data)
        }
        return element
    }
}
