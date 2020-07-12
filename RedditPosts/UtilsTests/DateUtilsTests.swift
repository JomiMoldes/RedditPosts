//
//  DateUtilsTests.swift
//  UtilsTests
//
//  Created by Miguel Moldes on 12/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import XCTest

@testable import Utils

public class DateUtilsTests: XCTestCase {
    
    func testTimeElapsed() {
        // Sunday, July 12, 2020 7:08:45 PM
        let now = Date(timeIntervalSince1970: 1594580925)
        // Saturday, July 11, 2020 7:08:45 PM
        let from = Date(timeIntervalSince1970: 1594494525)
        let timeElapsed: String = DateUtils().timeElapsed(from: from, to: now)
        XCTAssertEqual(timeElapsed, "1 day")
        
        // Saturday, July 11, 2020 9:08:45 PM
        let from2 = Date(timeIntervalSince1970: 1594501725)
        XCTAssertEqual(DateUtils().timeElapsed(from: from2, to: now), "22 hours")
        // Saturday, July 11, 2020 9:28:45 PM
        let from3 = Date(timeIntervalSince1970: 1594502925)
        XCTAssertEqual(DateUtils().timeElapsed(from: from3, to: now), "21 hours")
        
        // Saturday, July 12, 2020 7:01:45 PM
        let from4 = Date(timeIntervalSince1970: 1594580505)
        XCTAssertEqual(DateUtils().timeElapsed(from: from4, to: now), "7 minutes")
        
        // Sunday, July 12, 2020 7:07:00 PM
        let from5 = Date(timeIntervalSince1970: 1594580820)
        XCTAssertEqual(DateUtils().timeElapsed(from: from5, to: now), "1 minute")
        
        // Sunday, July 12, 2020 7:08:00 PM
        let from6 = Date(timeIntervalSince1970: 1594580880)
        XCTAssertEqual(DateUtils().timeElapsed(from: from6, to: now), "45 seconds")
    }
    
}
