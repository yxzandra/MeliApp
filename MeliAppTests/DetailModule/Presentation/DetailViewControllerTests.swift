import XCTest
@testable import MeliApp

class DetailViewControllerTests: XCTestCase {
    var sut: DetailViewController!
    var dispatch: DispatchQueue!
    var presenter: DetailPresenterMock!
    var dataSource: DetailDataSource!
    var delegate: DetailDelegate!
    
    override func setUp() {
        super.setUp()
        dispatch = DispatchQueueMock(label: "")
        presenter = DetailPresenterMock()
        dataSource = DetailDataSource()
        delegate = DetailDelegate()
        sut = DetailViewController(
            mainDispatchQueue: dispatch,
            dataSource: dataSource,
            delegate: delegate,
            presenter: presenter
        )
    }

    override func tearDown() {
        sut = nil
        presenter = nil
        dataSource = nil
        delegate = nil
        dispatch = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(presenter.viewDidLoadCalled)
        
        XCTAssertEqual(sut.view.backgroundColor, .backgroundColor)
        XCTAssertEqual(sut.navigationItem.title, "Detalle")
        
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.delegate)
        
        XCTAssertEqual(sut.loadIndicatorView.color, .titleColor)
    }
    
    func testPresentErrorViewSuccess() {
        sut.presenterErrorDataView()

        XCTAssertTrue(sut.showError)
        XCTAssertNil(sut.viewModel)
    }
    
    func testpresenterPushDataViewSuccess() {
        let viewModel = DetailViewModel.mocked()
        sut.presenterPushDataView(receivedData: viewModel)

        XCTAssertFalse(sut.showError)
        XCTAssertNotNil(sut.viewModel)
    }
    
    func testHideTableViewTrue() {
        sut.hideTableView(isHide: true)

        let expectation = self.expectation(description: "Test")
        dispatch.async {
            XCTAssertTrue(self.sut.tableView.isHidden)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 4, handler: nil)
    }
    
    func testHideTableViewFalse() {
        sut.hideTableView(isHide: false)
        
        let expectation = self.expectation(description: "Test")
        dispatch.async {
            XCTAssertFalse(self.sut.tableView.isHidden)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 4, handler: nil)
    }
    
    func testLoadActiviySuccess() {
        sut.loadActivity()
        let expectation = self.expectation(description: "Test")
        dispatch.async {
            XCTAssertTrue(self.sut.loadIndicatorView.isAnimating)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 4, handler: nil)
    }
    
    func testStopAndHideActivitySuccess() {
        sut.stopAndHideActivity()
        let expectation = self.expectation(description: "Test")
        dispatch.async {
            XCTAssertTrue(self.sut.loadIndicatorView.hidesWhenStopped)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 4, handler: nil)
    }
    
    func testValidateDescriptionCalledGetDetail() {
        let viewModel = DetailViewModel.mocked()
        sut.presenterPushDataView(receivedData: viewModel)
        
        sut.validateDescription()
        XCTAssertTrue(presenter.getDetailDescriptionCalled)
        
    }
    
    func testValidateDescriptionReloadRows() {
        var viewModel = DetailViewModel.mocked()
        viewModel.description = "Prueba"
        sut.viewDidLoad()
        sut.presenterPushDataView(receivedData: viewModel)
        
        sut.validateDescription()
        XCTAssertTrue(sut.showDescription)
        XCTAssertFalse(presenter.getDetailDescriptionCalled)
        
    }

    func testValidatePushDetailDataView() {
        let descriptionTest = "prueba"
        let viewModel = DetailViewModel.mocked()
        sut.viewDidLoad()
        sut.presenterPushDataView(receivedData: viewModel)
        sut.presenterPushDetailDataView(receivedData: descriptionTest)
        
        XCTAssertEqual(descriptionTest, sut.viewModel?.description)
        
    }

    func testValidateErrorDescriptionView() {
        let descriptionTest = "Ocurrió un error en la consulta"
        let viewModel = DetailViewModel.mocked()
        sut.viewDidLoad()
        sut.presenterPushDataView(receivedData: viewModel)
        sut.presenterErrorDescriptionView()
        
        XCTAssertEqual(descriptionTest, sut.viewModel?.description)
        
    }
}
