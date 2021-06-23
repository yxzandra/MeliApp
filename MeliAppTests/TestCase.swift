import Foundation
import Mimic
import XCTest

class TestCase: XCTestCase {
    let waiter = XCTWaiter()

    override func wait(for expectations: [XCTestExpectation], timeout seconds: TimeInterval) {
        let result = waiter.wait(for: expectations, timeout: seconds)
        let names: [String] = expectations.map { $0.description }
        print("Expectations \(names.joined(separator: ",")) finished with result: \(result.rawValue)")
        if result != XCTWaiter.Result.completed {
            XCTFail(
                """
                Asynchronous wait failed: Exceeded timeout of
                \(seconds) seconds, with unfulfilled expectations:
                \(names) from any object.
                """
            )
        }
    }

    override func setUp() {
        super.setUp()
        Mimic.start()
    }

    override func tearDown() {
        Mimic.stopAllMimics()
        super.tearDown()
    }
}
