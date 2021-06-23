import XCTest
@testable import MeliApp

class SitesWireFrameMock: SitesWireFrameProtocol {
    var presentViewSearchCalled = false
    
    static func createSitesModule() -> UIViewController {
        return SitesViewController()
    }
    
    func presentViewSearch(from view: SitesViewProtocol, idSide: String) {
        presentViewSearchCalled = true
    }
}
