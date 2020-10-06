//
//  RequestModelTests.swift
//  RedditClientTests
//
//  Created by Fernando Luna on 10/5/20.
//

import XCTest

@testable import RedditClient

class RequestModelTests: XCTestCase {
    
    var data: Data?
    
    override func setUpWithError() throws {
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "top", ofType: "json")  else {
            XCTFail()
            return
        }
        data = NSData(contentsOfFile: path) as Data?
    }
    
    override func tearDownWithError() throws {
        data = nil
    }
    
    
    func testRequestDecode() throws {
        let decoder = JSONDecoder()
        let response = try decoder.decode(ResponseRequest.self, from: self.data!)
        XCTAssertEqual(response.data.children.count, 25)
    }
    
}
