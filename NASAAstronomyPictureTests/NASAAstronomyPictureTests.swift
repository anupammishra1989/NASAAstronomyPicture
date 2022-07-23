//
//  NASAAstronomyPictureTests.swift
//  NASAAstronomyPictureTests
//
//  Created by anupam mishra on 21/07/22.
//

import XCTest
@testable import NASAAstronomyPicture

class NASAAstronomyPictureTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateFormat() throws {
        XCTAssertEqual("2022-07-19".toDate(dateFormat: dateFormatterGet)?.toString(), "Jul 19, 2022")
        XCTAssertNotEqual("2022-07-19".toDate(dateFormat: dateFormatterGet)?.toString(), "19 Jul, 2022")
    }
}
