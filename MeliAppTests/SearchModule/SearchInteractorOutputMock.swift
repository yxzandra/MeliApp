import XCTest
@testable import MeliApp

class SearchInteractorOutputMock: SearchInteractorOutputProtocol {
    var interactorPushDataPresenterCalled = false
    var interactorErrorDataPresenterCalled = false
    
    func interactorErrorDataPresenter() {
        interactorErrorDataPresenterCalled = true
    }
    
    func interactorPushDataPresenter(receivedData: [SearchViewModel]) {
        interactorPushDataPresenterCalled = true
    }
    
}
