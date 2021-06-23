import XCTest
@testable import MeliApp

class SearchInteractorTests: XCTestCase {
    var sut: SearchInteractor!
    var presenter: SearchInteractorOutputMock!
    var result: SearchRemoteDataManagerOutputMock!
    var remoteDatamanager: SearchRemoteDataManagerMock!
    
    override func setUp() {
        super.setUp()
        presenter = SearchInteractorOutputMock()
        result = SearchRemoteDataManagerOutputMock()
        remoteDatamanager = SearchRemoteDataManagerMock(remoteRequestHandler: result)
        sut = SearchInteractor(
            presenter: presenter,
            remoteDatamanager: remoteDatamanager
        )
    }

    override func tearDown() {
        sut = nil
        presenter = nil
        remoteDatamanager = nil
        result = nil
        super.tearDown()
    }
    
    func testsRemoteDataManagerReturnDataSuccess() {
        remoteDatamanager.success = true
        
        sut.searchItem(item: "", idSite: "")
        XCTAssertTrue(remoteDatamanager.externalSearchItemCalled)
        XCTAssertTrue(result.returnDataCalled)
        XCTAssertFalse(result.errorDataCalled)
    }
    
    func testRemoteDataManagerReturnEmptyData() {
        remoteDatamanager.success = false
        remoteDatamanager.emptyItem = true

        sut.searchItem(item: "", idSite: "")
        XCTAssertTrue(remoteDatamanager.externalSearchItemCalled)
        XCTAssertFalse(result.returnDataCalled)
        XCTAssertTrue(result.errorDataCalled)
    }

    func testRemoteDataManagerReturnError() {
        remoteDatamanager.success = false
        
        sut.searchItem(item: "", idSite: "")
        XCTAssertTrue(result.errorDataCalled)
        XCTAssertFalse(result.returnDataCalled)
    }

    func testPresenterErrorDataCalled() {
        sut.errorData()
        XCTAssertTrue(presenter.interactorErrorDataPresenterCalled)
        XCTAssertFalse(presenter.interactorPushDataPresenterCalled)
    }

    func testPresenterErrorDataWithEmptyData() {
        let model = try! Search.mocked(fileName: "search_empty_200")
        sut.returnData(data: model)
        XCTAssertTrue(presenter.interactorErrorDataPresenterCalled)
        XCTAssertFalse(presenter.interactorPushDataPresenterCalled)
    }
    
    func testPresenterPushDataSuccess() {
        let model = try! Search.mocked()
        sut.returnData(data: model)
        XCTAssertTrue(presenter.interactorPushDataPresenterCalled)
        XCTAssertFalse(presenter.interactorErrorDataPresenterCalled)
    }
}
