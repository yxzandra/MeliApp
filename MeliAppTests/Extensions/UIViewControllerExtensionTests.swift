import XCTest
@testable import MeliApp

class UIViewControllerExtensionTests: TestCase {
    var sut: UIViewController!

    override func setUp() {
        super.setUp()
        sut = UIViewController()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testShowToast() {
        sut.showToast(message: "message", seconds: 3.0)
        XCTAssertFalse(sut.isBeingPresented)
    }
}
