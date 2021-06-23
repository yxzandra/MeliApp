import XCTest
@testable import MeliApp

class SearchMapperTests: XCTestCase {
    
    var sut: SearchMapper!
    
    override func setUp() {
        super.setUp()
        sut = SearchMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testReverseMap() {
        guard let model = try? Search.mocked() else {
            fatalError("Failed to create model")
        }
        let referenceVM = SearchViewModel.mocked()

        let viewModel = sut.reverseMap(values: model.results)

        for i in 0 ..< viewModel.count {
            let search = viewModel[i]
            let searchViewModel = referenceVM[i]

            XCTAssertEqual(search.id, searchViewModel.id)
            XCTAssertEqual(search.title, searchViewModel.title)
            XCTAssertEqual(search.idSite, searchViewModel.idSite)
            XCTAssertEqual(search.thumbnail, searchViewModel.thumbnail)
        }
    }
}
