import XCTest
@testable import MeliApp

class SitesInteractorTests: XCTestCase {
    var sut: SitesInteractor!
    var presenter: SitesInteractorOutputMock!
    var result: SitesRemoteDataManagerOutputMock!
    var localDatamanager: SitesLocalDataManagerMock!
    var remoteDatamanager: SitesRemoteDataManagerMock!
    
    override func setUp() {
        super.setUp()
        presenter = SitesInteractorOutputMock()
        localDatamanager = SitesLocalDataManagerMock()
        result = SitesRemoteDataManagerOutputMock()
        remoteDatamanager = SitesRemoteDataManagerMock(remoteRequestHandler: result)
        sut = SitesInteractor(
            presenter: presenter,
            localDatamanager: localDatamanager,
            remoteDatamanager: remoteDatamanager
        )
    }

    override func tearDown() {
        sut = nil
        presenter = nil
        localDatamanager = nil
        remoteDatamanager = nil
        super.tearDown()
    }

    func testExternalGetDataSuccess() {
        remoteDatamanager.success = true

        sut.getSites()
        XCTAssertTrue(remoteDatamanager.externalGetDataCalled)
        XCTAssertTrue(result.returnDataCalled)
        XCTAssertFalse(result.errorDataCalled)
    }

    func testExternalGetDataFailure() {
        remoteDatamanager.success = false

        sut.getSites()
        XCTAssertTrue(remoteDatamanager.externalGetDataCalled)
        XCTAssertFalse(result.returnDataCalled)
        XCTAssertTrue(result.errorDataCalled)
    }
    
    func testInternalSiteSelectedCalled() {
        sut.siteSelected(idSide: "")
        XCTAssertTrue(localDatamanager.internalSaveSiteCalled)
    }
    
    func testPresenterErrorDataCalled() {
        sut.errorData()
        XCTAssertTrue(presenter.interactorErrorDataPresenterCalled)
        XCTAssertFalse(presenter.interactorPushDataPresenterCalled)
    }
    
    func testReturnDataCalled() {
        let model = try! Site.mocked()
        sut.returnData(sites: model)
        XCTAssertTrue(presenter.interactorPushDataPresenterCalled)
    }
    
}
