import XCTest
@testable import MeliApp

class DetailViewMock: DetailViewProtocol {
    var presenter: DetailPresenterProtocol?
    var presenterPushDataViewCalled = false
    var loadActivityCalled = false
    var stopAndHideActivityCalled = false
    var hideTableViewCalled = false
    var presenterErrorDataViewCalled = false
    var presenterErrorDescriptionViewCalled = false
    var presenterPushDetailDataViewCalled = false
    
    func loadActivity() {
        loadActivityCalled = true
    }
    
    func stopAndHideActivity() {
        stopAndHideActivityCalled = true
    }
    
    func hideTableView(isHide: Bool) {
        hideTableViewCalled = true
    }
    
    func presenterPushDataView(receivedData: DetailViewModel) {
        presenterPushDataViewCalled = true
    }
    
    func presenterPushDetailDataView(receivedData: String) {
        presenterPushDetailDataViewCalled = true
    }
    
    func presenterErrorDataView() {
        presenterErrorDataViewCalled = true
    }
    
    func presenterErrorDescriptionView() {
        presenterErrorDescriptionViewCalled = true
    }
    
    
}
