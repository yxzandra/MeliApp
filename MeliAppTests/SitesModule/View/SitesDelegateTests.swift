import XCTest
@testable import MeliApp

class SitesDelegateTests: XCTestCase {
    var sut: SitesDelegate!
    var tableView: UITableView!
    var presenter: SitesPresenterMock!
    var viewController: SitesViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = SitesDelegate()
        presenter = SitesPresenterMock()
        viewController = SitesViewController()
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
        let cellTypes = SitesCellTypes.default
        let viewModel = SiteViewModel.mocked()
        sut.viewController?.presenterPushDataView(receivedData: viewModel)

        for segmentIndex in 0 ..< cellTypes.count {
            let indexPath = IndexPath(row: .zero, section: segmentIndex)
            let cellSection = cellTypes[segmentIndex]
            switch cellSection {
            case .header:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                XCTAssertFalse(presenter.siteSelectedCalled)
            case .sites:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                XCTAssertTrue(presenter.siteSelectedCalled)
            }
        }
    }
    
    func testDidSelectRowRoutesWhenViewModelNil() {
        for segmentIndex in 0 ..< SitesCellTypes.default.count {
            let indexPath = IndexPath(row: .zero, section: segmentIndex)
            sut.tableView(tableView, didSelectRowAt: indexPath)
            XCTAssertFalse(presenter.siteSelectedCalled)
        }
    }
    
}
