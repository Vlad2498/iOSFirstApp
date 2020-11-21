//
//  HtmlDecoderTests.swift
//  FirstAppTests
//
//  Created by vlad on 21/11/2020.
//

import XCTest
@testable import FirstApp


class HtmlDecoderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHTMLDecoding() throws {
        let encodedString = "&quot;"
        
        XCTAssertEqual(encodedString.htmlDecoded, "\"")
        
        let encodedUmlaut = "&auml;"
        XCTAssert(encodedUmlaut.htmlDecoded == "ä")
    }

}
