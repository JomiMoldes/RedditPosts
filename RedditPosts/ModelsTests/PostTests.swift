//
//  PostTests.swift
//  PostTests
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import XCTest

@testable import Models

class PostTests: XCTestCase {
    
    func test_Decode() {
        
        do {
            let post: Post? = try self.decodeJSON(json: self.getPostJSON())
            XCTAssertEqual(post?.id, "1")
            XCTAssertEqual(post?.title, "Any title")
            XCTAssertEqual(post?.thumbnail, "http://b.thumbs.redditmedia.com/9N1f7UGKM5fPZydrsgbb4_SUyyLW7A27um1VOygY3LM.jpg")
        } catch let error {
            XCTFail("failed decoding \(error.localizedDescription)")
        }
        
    }

}

private extension PostTests {
    
    func getPostJSON() -> [String: Any] {
        return [
            "id": "1",
            "title": "Any title",
            "thumbnail": "http://b.thumbs.redditmedia.com/9N1f7UGKM5fPZydrsgbb4_SUyyLW7A27um1VOygY3LM.jpg"
        ]
    }
    
    func decodeJSON<T: Decodable>(json: [String: Any]) throws -> T? {
        let decoder = JSONDecoder()
        var element: T?
        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            element = try decoder.decode(T.self, from: data)
        }
        return element
    }
}