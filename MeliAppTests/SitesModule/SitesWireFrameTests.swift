import XCTest
@testable import MeliApp

class SitesWireFrameTests: XCTestCase {
    var sut: SitesWireFrame!
    
    override func setUp() {
        super.setUp()
        sut = SitesWireFrame()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCreateSearchModuleSuccess() {
        let createModule = SitesWireFrame.createSitesModule()
        XCTAssertNotNil(createModule.children.first as? SitesViewController)
    }
    
    func testPresentViewSearchSuccess() {
        let createModule = SitesWireFrame.createSitesModule()
        let navigationController = createModule as! UINavigationController
        let viewController = createModule.children.first as! SitesViewProtocol
        let childrenCount = navigationController.children.count
        
        sut.presentViewSearch(from: viewController, idSide: "")
        XCTAssertEqual(childrenCount, navigationController.children.count)
    }

}

