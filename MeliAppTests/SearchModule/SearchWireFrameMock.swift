import XCTest
@testable import MeliApp

class SearchWireFrameMock: SearchWireFrameProtocol {
    var presentViewDetailCalled = false

    static func createSearchModule(with data: String) -> UIViewController {
        return SearchViewController()
    }

    func presentViewDetail(from view: SearchViewProtocol, idItem: String) {
        presentViewDetailCalled = true
    }
}
