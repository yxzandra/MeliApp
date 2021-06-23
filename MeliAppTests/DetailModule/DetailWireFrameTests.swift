import XCTest
@testable import MeliApp

class DetailWireFrameTests: XCTestCase {

    func testCreateSearchModuleSuccess() {
        let createModule = SearchWireFrame.createSearchModule(with: "")
        XCTAssertNotNil(createModule as? SearchViewController)
    }
}
