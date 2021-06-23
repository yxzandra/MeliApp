import XCTest
@testable import MeliApp

class DetailMapperTests: XCTestCase {
    var sut: DetailMapper!
    
    override func setUp() {
        super.setUp()
        sut = DetailMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testReverseMap() {
        guard let model = try? Detail.mocked() else {
            fatalError("Failed to create model")
        }

        let viewModel = sut.reverseMap(value: model)

        XCTAssertEqual(model.id, viewModel.id)
        XCTAssertEqual(model.siteID, viewModel.idSite)
        XCTAssertEqual(model.title, viewModel.title)
        XCTAssertNil(viewModel.description)
    }
}
