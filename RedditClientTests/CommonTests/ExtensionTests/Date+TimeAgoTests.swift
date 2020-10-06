//
//  Date+TimeAgoTests.swift
//  RedditClientTests
//
//  Created by Fernando Luna on 10/5/20.
//

import XCTest

@testable import RedditClient

class Date_TimeAgoTests: XCTestCase {

    
    func testNowRelativeTime() throws {
        let date: Date = Date()
        XCTAssertEqual(date.relativeTime, "")
    }
    
    func testOneYearAgo() throws {
        guard let date: Date = Calendar.current.date(byAdding: .year, value: -1, to: Date()) else {
            XCTFail()
            return
        }
        XCTAssertEqual(date.relativeTime, "1 year ago")
    }
    
    func testOneYearAgoTwo() throws {
        guard let date: Date = Calendar.current.date(byAdding: .day, value: -380, to: Date()) else {
            XCTFail()
            return
        }
        XCTAssertEqual(date.relativeTime, "1 year ago")
    }
    
    func testOneMonthAgo() throws {
        guard let date: Date = Calendar.current.date(byAdding: .month, value: -1, to: Date()) else {
            XCTFail()
            return
        }
        XCTAssertEqual(date.relativeTime, "1 month ago")
    }
    
    func testOneHourAgo() throws {
        guard let date: Date = Calendar.current.date(byAdding: .hour, value: -1, to: Date()) else {
            XCTFail()
            return
        }
        XCTAssertEqual(date.relativeTime, "1 hour ago")
    }
    
    func testTwoHourAgo() throws {
        guard let date: Date = Calendar.current.date(byAdding: .hour, value: -2, to: Date()) else {
            XCTFail()
            return
        }
        XCTAssertEqual(date.relativeTime, "2 hours ago")
    }
    
    func testTwoHourAgoTwo() throws {
        guard let date: Date = Calendar.current.date(byAdding: .minute, value: -130, to: Date()) else {
            XCTFail()
            return
        }
        XCTAssertEqual(date.relativeTime, "2 hours ago")
    }

}
