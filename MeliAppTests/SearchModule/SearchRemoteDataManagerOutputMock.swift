import XCTest
@testable import MeliApp

class SearchRemoteDataManagerOutputMock: SearchRemoteDataManagerOutputProtocol {
    var returnDataCalled = false
    var errorDataCalled = false

    func returnData(data: Search) {
        returnDataCalled = true
    }

    func errorData() {
        errorDataCalled = true
    }
}
