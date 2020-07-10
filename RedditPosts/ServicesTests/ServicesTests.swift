//
//  ServicesTests.swift
//  ServicesTests
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import XCTest

@testable import Services

class ServicesTests: XCTestCase {

    // TO DO: This was intended to test the API. To test it properly we should mock the API.
    func _testService() {
        let service = PostsService(deviceId: "2345234523452345")
        let exp = self.expectation(description: "service")
        service.fetch(after: "1", callback: { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                return
            }
            exp.fulfill()
        })
        self.waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    // TO DO: test failing cases

}
