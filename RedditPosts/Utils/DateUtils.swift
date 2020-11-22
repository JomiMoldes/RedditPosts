//
//  DateUtils.swift
//  UtilsTests
//
//  Created by Miguel Moldes on 12/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation

public class DateUtils: DateUtilsProtocol {
    
    public init() { }
    
    public func timeElapsed(from: Date, to: Date) -> String {
        let components = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: from, to: to)
        if let days = components.day, days > 0 {
            return days == 1 ? "1 day" : "\(days) days"
        }
        if let hours = components.hour, hours > 0 {
            return hours == 1 ? "1 hour" : "\(hours) hours"
        }
        if let minutes = components.minute, minutes > 0 {
            return minutes == 1 ? "1 minute" : "\(minutes) minutes"
        }
        if let seconds = components.second, seconds > 0 {
            return seconds == 1 ? "1 second" : "\(seconds) seconds"
        }
        return ""
    }
    
}
