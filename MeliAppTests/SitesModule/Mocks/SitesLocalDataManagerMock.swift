import XCTest
@testable import MeliApp

class SitesLocalDataManagerMock: SitesLocalDataManagerInputProtocol {
    var internalSaveSiteCalled = false
    var getSiteSavedCalled = false
    
    func internalSaveSite(idSite: String) {
        internalSaveSiteCalled = true
    }
    
    func getSiteSaved() -> String? {
        getSiteSavedCalled = true
        return  nil
    }
}
