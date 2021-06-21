import XCTest
@testable import MeliApp

class SearchRemoteDataManagerMock: SearchRemoteDataManager {
    var success = true
    var emptyItem = true
    var externalSearchItemCalled = false
    
    override func externalSearchItem(item: String, idSite: String) {
        externalSearchItemCalled = true
        if success {
            var model: Search
            if emptyItem {
                model = try! Search.mocked(fileName: "search_empty_200")
            } else {
                model = try! Search.mocked()
            }
            remoteRequestHandler?.returnData(data: model)
        } else {
            remoteRequestHandler?.errorData()
        }
    }
}
