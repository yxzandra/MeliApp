import XCTest
@testable import MeliApp

class SitesLocalDataManagerMock: SitesLocalDataManagerInputProtocol {
    var internalSaveSiteCalled = false
    
    func internalSaveSite(idSite: String) {
        internalSaveSiteCalled = true
    }
}
