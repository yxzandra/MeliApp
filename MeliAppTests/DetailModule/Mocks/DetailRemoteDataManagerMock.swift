import XCTest
@testable import MeliApp

class DetailRemoteDataManagerMock: DetailRemoteDataManager {
    var success = true
    var externalDetailItemCalled = false
    var externalDescriptionItemCalled = false
    
    override func externalDetailItem(idItem: String) {
        externalDetailItemCalled = true

        if success {
            let model = try! Detail.mocked()
            remoteRequestHandler?.returnData(data: model)
        } else {
            remoteRequestHandler?.errorData()
        }
    }
    
    override func externalDescriptionItem(idItem: String) {
        externalDescriptionItemCalled = true

        if success {
            let model = try! Description.mocked()
            remoteRequestHandler?.returnDescription(data: model)
        } else {
            remoteRequestHandler?.errorDescription()
        }
    }
}
