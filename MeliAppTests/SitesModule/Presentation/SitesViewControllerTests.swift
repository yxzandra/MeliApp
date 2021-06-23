import XCTest
@testable import MeliApp

class SitesViewControllerTests: XCTestCase {
    var sut: SitesViewController!
    var dispatch: DispatchQueue!
    var presenter: SitesPresenterMock!
    var dataSource: SitesDataSource!
    var delegate: SitesDelegate!
    
    override func setUp() {
        super.setUp()
        dispatch = DispatchQueueMock(label: "")
        presenter = SitesPresenterMock()
        dataSource = SitesDataSource()
        delegate = SitesDelegate()
        sut = SitesViewController(
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
        XCTAssertEqual(sut.navigationItem.title, "Paises Asociados")
        
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.delegate)
        
        XCTAssertEqual(sut.loadIndicatorView.color, .titleColor)
    }
    
    func testPresentErrorViewSuccess() {
        sut.presenterErrorView()

        XCTAssertTrue(sut.showError)
        XCTAssertNil(sut.viewModel)
    }
    
    func testpresenterPushDataViewSuccess() {
        let viewModel = SiteViewModel.mocked()
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
}

