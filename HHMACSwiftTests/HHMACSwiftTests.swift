//
//  HHMACSwiftTests.swift
//  HHMACSwiftTests
//
//  Created by Yannick Heinrich on 11.04.16.
//  Copyright © 2016 yageek. All rights reserved.
//

import XCTest
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

}
