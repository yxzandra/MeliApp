import XCTest
@testable import MeliApp

class SearchViewControllerTests: XCTestCase {
    var sut: SearchViewController!
    var dispatch: DispatchQueue!
    var presenter: SearchPresenterMock!
    var dataSource: SearchDataSource!
    var delegate: SearchDelegate!
    
    override func setUp() {
        super.setUp()
        dispatch = DispatchQueueMock(label: "")
        presenter = SearchPresenterMock()
        dataSource = SearchDataSource()
        delegate = SearchDelegate()
        sut = SearchViewController(
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
        super.tearDown()
    }
    
    
    func testViewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(presenter.viewDidLoadCalled)
        
        XCTAssertEqual(sut.view.backgroundColor, .backgroundColor)
        XCTAssertEqual(sut.navigationItem.title, "Busca tu artículo")
        
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.delegate)
        
        XCTAssertEqual(sut.loadIndicatorView.color, .titleColor)
    }
    
    func testPresentErrorViewSuccess() {
        sut.presenterErrorView()

        XCTAssertTrue(sut.showError)
        XCTAssertNil(sut.viewModel)
    }

    func testpresenterPushDataViewWithViewModelNil() {
        sut.presenterPushDataView(receivedData: nil)

        XCTAssertFalse(sut.showError)
        XCTAssertNil(sut.viewModel)
    }
    
    func testpresenterPushDataViewSuccess() {
        let viewModel = SearchViewModel.mocked()
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
