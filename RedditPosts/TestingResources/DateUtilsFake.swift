//
//  DateUtilsFake.swift
//  TestingResources
//
//  Created by Miguel Moldes on 12/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UtilsInterfaces

public class DateUtilsFake: DateUtilsProtocol {
    
    public init() { }
    
    public func timeElapsed(from: Date, to: Date) -> String {
        return ""
    }
    
}
