import XCTest
@testable import MeliApp

class SitesInteractorOutputMock: SitesInteractorOutputProtocol {
    var interactorPushDataPresenterCalled = false
    var interactorErrorDataPresenterCalled = false
    
    func interactorPushDataPresenter(receivedData: [SiteViewModel]) {
        interactorPushDataPresenterCalled = true
    }
    
    func interactorErrorDataPresenter(statusCode: Int, error: Error) {
        interactorErrorDataPresenterCalled = true
    }
}
