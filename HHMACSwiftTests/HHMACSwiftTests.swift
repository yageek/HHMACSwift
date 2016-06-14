//
//  HHMACSwiftTests.swift
//  HHMACSwiftTests
//
//  Created by Yannick Heinrich on 11.04.16.
//  Copyright © 2016 yageek. All rights reserved.
//

import XCTest
import CryptoSwift
@testable import HHMACSwift

class HHMACSwiftTests: XCTestCase {

    func testNilCharacteristic() {
        let URL = NSURL(string: "example.com")!
        let request = NSURLRequest(URL: URL)

        XCTAssertEqual(request.characteristic, "", "The characteristic should be empty")
    }

    func testCharacteristic() {

        let URL = NSURL(string: "https://example.com")!
        let request = NSURLRequest(URL: URL)

        XCTAssertEqual(request.characteristic, "example.com_get", "The characteristic should match")

    }

    func testComponentsCharacteristic() {

        let URL = NSURL(string: "https://example.com/test/path?obj=1")!
        let request = NSURLRequest(URL: URL)

        XCTAssertEqual(request.characteristic, "example.com_get_obj_1_path_test", "The characteristic should match")
        
    }

    let golangDate: NSDate = {
        let dateCmpt = NSDateComponents()
        dateCmpt.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        dateCmpt.year = 2009;
        dateCmpt.month = 11;
        dateCmpt.day = 10;
        dateCmpt.hour = 23;
        dateCmpt.minute = 0;
        dateCmpt.second = 0;
        dateCmpt.timeZone = NSTimeZone(abbreviation: "UTC")!

        return dateCmpt.date!

    }()

    func testGoTimeComputing() {

        let dateString = "\(Int64(golangDate.timeIntervalSince1970*1e9))"
        XCTAssertEqual("1257894000000000000", dateString, "Should have the same value has the golang one")
    }

    func testHashFunction() {
        let URL = NSURL(string: "https://example.com/test/path?obj=1")!
        let request = NSURLRequest(URL: URL)

        let expected = "cXWo+9uttU6KINQYf4tipx0NnbnEPmtFkl6t7s+52Z0="

        let hash = request.hash(golangDate, publicKey: "42", secretKey: "MYSECRET", variant: .sha256)

        XCTAssertEqual(hash, expected, "The hash should be equal")

    }
 }
