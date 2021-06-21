import XCTest
@testable import MeliApp

class SearchInteractorInputMock: SearchInteractorInputProtocol {
    var presenter: SearchInteractorOutputProtocol?
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol?
    
    var searchItemCalled = false
    
    func searchItem(item: String, idSite: String) {
        searchItemCalled = true
    }
}
