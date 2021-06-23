import XCTest
@testable import MeliApp

class PictureMapperTests: XCTestCase {
    var sut: PictureMapper!
    
    override func setUp() {
        super.setUp()
        sut = PictureMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testReverseMap() {
        guard let model = try? Detail.mocked() else {
            fatalError("Failed to create model")
        }
        let referenceVM = DetailViewModel.mocked().pictures

        let viewModel = sut.reverseMap(values: model.pictures)

        for i in 0 ..< viewModel.count {
            let picture = viewModel[i]
            let pictureViewModel = referenceVM[i]

            XCTAssertEqual(picture, pictureViewModel)
        }
    }
}
