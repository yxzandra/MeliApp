import XCTest
@testable import MeliApp

class SitesInteractorInputMock: SitesInteractorInputProtocol {
    var presenter: SitesInteractorOutputProtocol?
    var localDatamanager: SitesLocalDataManagerInputProtocol?
    var remoteDatamanager: SitesRemoteDataManagerInputProtocol?
    
    var getSitesCalled = false
    var siteSelectedCalled = false
    
    func getSites() {
        getSitesCalled = true
    }
    
    func siteSelected(idSide: String) {
        siteSelectedCalled = true
    }
}
