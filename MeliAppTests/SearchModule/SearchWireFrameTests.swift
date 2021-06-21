//
//  SearchWireFrameTests.swift
//  MeliAppTests
//
//  Created by Yxzandra Cordero on 21-06-21.
//

import XCTest
@testable import MeliApp

class SearchWireFrameTests: XCTestCase {
    var sut: SearchWireFrame!
    
    
    override func setUp() {
        super.setUp()
        sut = SearchWireFrame()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCreateSearchModuleSuccess() {
        let createModule = SearchWireFrame.createSearchModule(with: "")
        XCTAssertNotNil(createModule as? SearchViewController)
    }
}
