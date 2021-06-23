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
    
    func testPresentViewDetailSuccess() {
        let createModule = SearchWireFrame.createSearchModule(with: "")
        sut.presentViewDetail(from: createModule as! SearchViewProtocol, idItem: "")

        XCTAssertFalse(createModule.isBeingPresented)
    }
}
