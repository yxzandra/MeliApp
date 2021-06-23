import XCTest
@testable import MeliApp

class UIViewTests: TestCase {
    var sut: UIView!

    override func setUp() {
        super.setUp()
        sut = UIView(frame: .zero)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAddAutoLayoutSubviews() {
        let view = UIView(frame: .zero)
        sut.addAutoLayout(subview: view)

        for subview in sut.subviews {
            XCTAssertFalse(subview.translatesAutoresizingMaskIntoConstraints)
        }
    }
}
