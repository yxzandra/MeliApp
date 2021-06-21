import XCTest
@testable import MeliApp

class SearchDelegateTests: XCTestCase {
    var sut: SearchDelegate!
    var tableView: UITableView!
    var presenter: SearchPresenterMock!
    var viewController: SearchViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = SearchDelegate()
        presenter = SearchPresenterMock()
        viewController = SearchViewController()
        viewController.presenter = presenter
        tableView = UITableView()
        
        sut.viewController = viewController
        tableView.delegate = sut
    }
    
    override func tearDown() {
        super.tearDown()
        tableView = nil
        viewController = nil
        sut = nil
        presenter = nil
    }
    
    func testDidSelectRowRoutesWhenAppropiate() {
        let cellTypes = SearchCellTypes.default
        let viewModel = SearchViewModel.mocked()
        sut.viewController?.presenterPushDataView(receivedData: viewModel)

        for segmentIndex in 0 ..< cellTypes.count {
            let indexPath = IndexPath(row: .zero, section: segmentIndex)
            let cellSection = cellTypes[segmentIndex]
            switch cellSection {
            case .search, .error:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                break
            case .items:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                XCTAssertTrue(presenter.itemSelectedCalled)
            }
        }
    }
    
    func testDidSelectRowRoutesWhenViewModelNil() {
        for segmentIndex in 0 ..< SitesCellTypes.default.count {
            let indexPath = IndexPath(row: .zero, section: segmentIndex)
            sut.tableView(tableView, didSelectRowAt: indexPath)
            XCTAssertFalse(presenter.itemSelectedCalled)
        }
    }
    
}
