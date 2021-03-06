import XCTest
@testable import MeliApp

class SitesRemoteDataManagerMock: SitesRemoteDataManager {
    var success = true
    var externalGetDataCalled = false
    
    override func externalGetData() {
        externalGetDataCalled = true
        if success {
            let model = try! Site.mocked()
            remoteRequestHandler?.returnData(sites: model)
        } else {
            remoteRequestHandler?.errorData()
        }
    }
}
