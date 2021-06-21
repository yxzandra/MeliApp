import XCTest
@testable import MeliApp

class SitesRemoteDataManagerOutputMock: SitesRemoteDataManagerOutputProtocol {
    var returnDataCalled = false
    var errorDataCalled = false
    
    func returnData(sites: [Site]) {
        returnDataCalled = true
    }

    func errorData() {
        errorDataCalled = true
    }
    
}
