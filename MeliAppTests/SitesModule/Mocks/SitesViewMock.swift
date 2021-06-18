import XCTest
@testable import MeliApp

class SitesViewMock: SitesViewProtocol {
    var presenter: SitesPresenterProtocol?
    var presenterPushDataViewCalled = false
    var loadActivityCalled = false
    var stopAndHideActivityCalled = false
    var hideTableViewCalled = false
    var showMessageErrorCalled = false
    var hideRetryButtonCalled = false
    
    func presenterPushDataView(receivedData: [SiteViewModel]) {
        presenterPushDataViewCalled = true
    }
    
    func loadActivity() {
        loadActivityCalled = true
    }
    
    func stopAndHideActivity() {
        stopAndHideActivityCalled = true
    }
    
    func hideTableView(isHide: Bool) {
        hideTableViewCalled = true
    }

    func showMessageError(message: String) {
        showMessageErrorCalled = true
    }

    func hideRetryButton(isHide: Bool) {
        hideRetryButtonCalled = true
    }

}
