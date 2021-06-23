import XCTest
@testable import MeliApp

class DetailInteractorTests: XCTestCase {
    var sut: DetailInteractor!
    var presenter: DetailInteractorOutputMock!
    var result: DetailRemoteDataManagerOutputMock!
    var remoteDatamanager: DetailRemoteDataManagerMock!
    
    override func setUp() {
        super.setUp()
        presenter = DetailInteractorOutputMock()
        result = DetailRemoteDataManagerOutputMock()
        remoteDatamanager = DetailRemoteDataManagerMock(remoteRequestHandler: result)
        sut = DetailInteractor(
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
        
        sut.getDetailItem(idItem: "")
        XCTAssertTrue(remoteDatamanager.externalDetailItemCalled)
        XCTAssertTrue(result.returnDataCalled)
        XCTAssertFalse(result.errorDataCalled)
    }

    func testRemoteDataManagerReturnError() {
        remoteDatamanager.success = false
        
        sut.getDetailItem(idItem: "")
        XCTAssertTrue(remoteDatamanager.externalDetailItemCalled)
        XCTAssertTrue(result.errorDataCalled)
        XCTAssertFalse(result.returnDataCalled)
    }
    
    
    func testsRemoteDataManagerReturnDescriptionSuccess() {
        remoteDatamanager.success = true
        
        sut.getDescriptionItem(idItem: "")
        XCTAssertTrue(remoteDatamanager.externalDescriptionItemCalled)
        XCTAssertTrue(result.returnDescriptionCalled)
        XCTAssertFalse(result.errorDescriptionCalled)
    }

    func testRemoteDataManagerReturnErrorDescription() {
        remoteDatamanager.success = false
        
        sut.getDescriptionItem(idItem: "")
        XCTAssertTrue(remoteDatamanager.externalDescriptionItemCalled)
        XCTAssertTrue(result.errorDescriptionCalled)
        XCTAssertFalse(result.returnDescriptionCalled)
    }

    func testPresenterErrorDataCalled() {
        sut.errorData()
        XCTAssertTrue(presenter.interactorErrorDataPresenterCalled)
        XCTAssertFalse(presenter.interactorPushDataPresenterCalled)
    }
    
    func testPresenterPushDataSuccess() {
        let model = try! Detail.mocked()
        sut.returnData(data: model)
        XCTAssertTrue(presenter.interactorPushDataPresenterCalled)
        XCTAssertFalse(presenter.interactorErrorDataPresenterCalled)
    }
    
    func testErrorDescriptionCalled() {
        sut.errorDescription()
        XCTAssertTrue(presenter.interactorErrorDescriptionPresenterCalled)
        XCTAssertFalse(presenter.interactorPushDescriptionPresenterCalled)
    }
    
    func testReturnDescriptionSuccess() {
        let model = try! Description.mocked()
        sut.returnDescription(data: model)
        XCTAssertTrue(presenter.interactorPushDescriptionPresenterCalled)
        XCTAssertFalse(presenter.interactorErrorDescriptionPresenterCalled)
    }
}
