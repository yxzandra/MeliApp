import XCTest
@testable import MeliApp

class DetailRemoteDataManagerOutputMock: DetailRemoteDataManagerOutputProtocol {
    var returnDataCalled = false
    var errorDataCalled = false
    var returnDescriptionCalled = false
    var errorDescriptionCalled = false
    
    func returnData(data: Detail) {
        returnDataCalled = true
    }
    
    func returnDescription(data: Description) {
        returnDescriptionCalled = true
    }
    
    func errorData() {
        errorDataCalled = true
    }
    
    func errorDescription() {
        errorDescriptionCalled = true
    }
    
}
