import XCTest
@testable import MeliApp

class DetailPresenterTests: XCTestCase {
    var sut: DetailPresenter!
    var interactor: DetailInteractorInputMock!
    var view: DetailViewMock!
    
    override func setUp() {
        super.setUp()
        view = DetailViewMock()
        interactor = DetailInteractorInputMock()
        sut = DetailPresenter(
            view: view,
            interactor: interactor,
            wireFrame: DetailWireFrame()
        )
    }

    override func tearDown() {
        sut = nil
        interactor = nil
        view = nil
        super.tearDown()
    }
    
    func testViewDidLoadSuccess() {
        sut.viewDidLoad(idItem: "")

        XCTAssertTrue(view.loadActivityCalled)
        XCTAssertTrue(view.hideTableViewCalled)
        XCTAssertTrue(interactor.getDetailItemCalled)
    }

    func testGetDetailDescriptionSuccess() {
        sut.getDetailDescription(idItem: "")

        XCTAssertTrue(interactor.getDescriptionItemCalled)
    }

    func testInteractorErrorDataPresenterSuccess(){
        sut.interactorErrorDataPresenter()
        
        XCTAssertTrue(view.stopAndHideActivityCalled)
        XCTAssertTrue(view.hideTableViewCalled)
        XCTAssertTrue(view.presenterErrorDataViewCalled)
    }

    func testInteractorPushDataPresenterSuccess() {
        let viewModel = DetailViewModel.mocked()
        sut.interactorPushDataPresenter(receivedData: viewModel)
        
        XCTAssertTrue(view.stopAndHideActivityCalled)
        XCTAssertTrue(view.presenterPushDataViewCalled)
        XCTAssertTrue(view.hideTableViewCalled)
    }
    
    func testInteractorErrorDescriptionPresenterSuccess() {
        sut.interactorErrorDescriptionPresenter()
        XCTAssertTrue(view.presenterErrorDescriptionViewCalled)
    }
    
    func testInteractorPushDescriptionPresenterSuccess() {
        let descriptionTest = "TestPrueba"
        sut.interactorPushDescriptionPresenter(receivedData: descriptionTest)
        XCTAssertTrue(view.presenterPushDetailDataViewCalled)
    }
}
