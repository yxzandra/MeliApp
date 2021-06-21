import XCTest
@testable import MeliApp

class SiteMapperTests: XCTestCase {
    var sut: SiteMapper!
    
    override func setUp() {
        super.setUp()
        sut = SiteMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testReverseMap() {
        guard let model = try? Site.mocked() else {
            fatalError("Failed to create model")
        }
        let referenceVM = SiteViewModel.mocked()

        let viewModel = sut.reverseMap(values: model)

        for i in 0 ..< viewModel.count {
            let site = viewModel[i]
            let siteViewModel = referenceVM[i]

            XCTAssertEqual(site.id, siteViewModel.id)
            XCTAssertEqual(site.name, siteViewModel.name)
        }
    }
}
