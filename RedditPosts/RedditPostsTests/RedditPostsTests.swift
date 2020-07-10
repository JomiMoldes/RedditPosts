//
//  RedditPostsTests.swift
//  RedditPostsTests
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import XCTest
import ServicesInterfaces
import Services
@testable import RedditPosts

class RedditPostsTests: XCTestCase {

    func testService() {
        let device_id = UIDevice.current.identifierForVendor?.uuidString ?? "3452345609872345345"
        let sut = PostsService(deviceId: device_id)
        let exp = self.expectation(description: "service")
        sut.fetch(after: "1") { result in 
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 10.0) { error in
            print(error)
        }
    }
}
