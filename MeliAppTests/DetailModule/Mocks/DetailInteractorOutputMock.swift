import XCTest
@testable import MeliApp

class DetailInteractorOutputMock: DetailInteractorOutputProtocol {
    var interactorErrorDataPresenterCalled = false
    var interactorErrorDescriptionPresenterCalled = false
    var interactorPushDataPresenterCalled = false
    var interactorPushDescriptionPresenterCalled = false
    
    func interactorErrorDataPresenter() {
        interactorErrorDataPresenterCalled = true
    }
    
    func interactorErrorDescriptionPresenter() {
        interactorErrorDescriptionPresenterCalled = true
    }
    
    func interactorPushDataPresenter(receivedData: DetailViewModel) {
        interactorPushDataPresenterCalled = true
    }
    
    func interactorPushDescriptionPresenter(receivedData: String) {
        interactorPushDescriptionPresenterCalled = true
    }
}
