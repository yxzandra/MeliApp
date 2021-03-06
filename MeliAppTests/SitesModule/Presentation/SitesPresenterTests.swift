import XCTest
@testable import MeliApp

class SitesPresenterTests: XCTestCase {
    var sut: SitesPresenter!
    var interactor: SitesInteractorInputMock!
    var view: SitesViewMock!
    var wireFrame: SitesWireFrameMock!
    
    override func setUp() {
        super.setUp()
        view = SitesViewMock()
        wireFrame = SitesWireFrameMock()
        interactor = SitesInteractorInputMock()
        sut = SitesPresenter(
            view: view,
            interactor: interactor,
            wireFrame: wireFrame
        )
    }

    override func tearDown() {
        sut = nil
        interactor = nil
        view = nil
        wireFrame = nil
        super.tearDown()
    }
    
    func testViewDidLoadSuccess() {
        sut.viewDidLoad()

        XCTAssertTrue(interactor.getSitesCalled)
        XCTAssertTrue(view.hideTableViewCalled)
        XCTAssertTrue(view.loadActivityCalled)
    }
    
    func testSiteSelectedSuccess() {
        let siteViewModel = SiteViewModel.mockedItem()
        sut.siteSelected(site: siteViewModel)

        XCTAssertTrue(interactor.siteSelectedCalled)
        XCTAssertTrue(wireFrame.presentViewSearchCalled)
    }

    func testInteractorErrorDataPresenter(){
        sut.interactorErrorDataPresenter()
        
        XCTAssertTrue(view.stopAndHideActivityCalled)
        XCTAssertTrue(view.presenterErrorViewCalled)
        XCTAssertTrue(view.hideTableViewCalled)
    }
    
    func testInteractorPushDataPresenter() {
        let viewModel = SiteViewModel.mocked()
        sut.interactorPushDataPresenter(receivedData: viewModel)
        
        XCTAssertTrue(view.stopAndHideActivityCalled)
        XCTAssertTrue(view.presenterPushDataViewCalled)
        XCTAssertTrue(view.hideTableViewCalled)
    }
}
