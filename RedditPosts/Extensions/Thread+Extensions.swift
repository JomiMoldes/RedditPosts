//
//  Thread+Extensions.swift
//  Extensions
//
//  Created by Miguel Moldes on 11/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation

public func ensureMainThread(_ completion: @escaping () -> Void) {
    if Thread.isMainThread {
        completion()
        return
    }
    DispatchQueue.main.async {
        completion()
    }
}
