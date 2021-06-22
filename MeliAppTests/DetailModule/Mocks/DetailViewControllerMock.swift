import XCTest
@testable import MeliApp

class DetailViewControllerMock: DetailViewController {
    var validateDescriptionCalled = false
    
    override func validateDescription() {
        validateDescriptionCalled = true
    }
}
