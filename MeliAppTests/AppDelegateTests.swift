import XCTest
@testable import MeliApp

class AppDelegateTests: TestCase {
    var sut: AppDelegate!
    
    override func setUp() {
        super.setUp()
        sut = UIApplication.shared.delegate as? AppDelegate
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testApplicationDidFinishLaunchingWithOptions() {
        let result = sut.application(UIApplication.shared,didFinishLaunchingWithOptions: nil)
        XCTAssertTrue(result)
    }
}
