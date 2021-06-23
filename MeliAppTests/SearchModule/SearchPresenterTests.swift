import XCTest
@testable import MeliApp

class SearchPresenterTests: XCTestCase {
    var sut: SearchPresenter!
    var interactor: SearchInteractorInputMock!
    var view: SearchViewMock!
    var wireFrame: SearchWireFrameMock!
    
    override func setUp() {
        super.setUp()
        view = SearchViewMock()
        wireFrame = SearchWireFrameMock()
        interactor = SearchInteractorInputMock()
        sut = SearchPresenter(
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
        sut.viewDidLoad(idSite: "")

        XCTAssertTrue(view.presenterPushDataViewCalled)
        XCTAssertTrue(view.hideTableViewCalled)
    }

    func testSearchItemSuccess() {
        sut.searchItem(item: "")

        XCTAssertTrue(view.hideTableViewCalled)
        XCTAssertTrue(interactor.searchItemCalled)
        XCTAssertTrue(view.loadActivityCalled)
    }
    
    func testItemSelectedSuccess() {
        sut.itemSelected(idItem: "")

        XCTAssertTrue(wireFrame.presentViewDetailCalled)
    }

    func testInteractorErrorDataPresenter(){
        sut.interactorErrorDataPresenter()
        
        XCTAssertTrue(view.stopAndHideActivityCalled)
        XCTAssertTrue(view.hideTableViewCalled)
        XCTAssertTrue(view.presenterErrorViewCalled)
    }

    func testInteractorPushDataPresenter() {
        let viewModel = SearchViewModel.mocked()
        sut.interactorPushDataPresenter(receivedData: viewModel)
        
        XCTAssertTrue(view.stopAndHideActivityCalled)
        XCTAssertTrue(view.presenterPushDataViewCalled)
        XCTAssertTrue(view.hideTableViewCalled)
    }
}
