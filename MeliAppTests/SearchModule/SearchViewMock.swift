import XCTest
@testable import MeliApp

class SearchViewMock: SearchViewProtocol {
    var presenter: SearchPresenterProtocol?
    var presenterPushDataViewCalled = false
    var loadActivityCalled = false
    var stopAndHideActivityCalled = false
    var hideTableViewCalled = false
    var presenterErrorViewCalled = false

    func loadActivity() {
        loadActivityCalled = true
    }

    func stopAndHideActivity() {
        stopAndHideActivityCalled = true
    }

    func hideTableView(isHide: Bool) {
        hideTableViewCalled = true
    }

    func presenterPushDataView(receivedData: [SearchViewModel]?) {
        presenterPushDataViewCalled = true
    }

    func presenterErrorView() {
        presenterErrorViewCalled = true
    }
}
