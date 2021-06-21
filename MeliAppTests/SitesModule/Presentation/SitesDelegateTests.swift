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
        tableView = nil
        viewController = nil
        sut = nil
        presenter = nil
        super.tearDown()
    }
    
    func testDidSelectRowRoutesWhenViewModelNotNil() {
        let viewModel = SiteViewModel.mocked()
        let cellTypes = SitesCellTypes.filteredCellTypes(viewModel: viewModel, showError: false)
        sut.viewController?.presenterPushDataView(receivedData: viewModel)

        for segmentIndex in 0 ..< cellTypes.count {
            let indexPath = IndexPath(row: .zero, section: segmentIndex)
            let cellSection = cellTypes[segmentIndex]
            switch cellSection {
            case .header:
                break
            case .sites:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                XCTAssertTrue(presenter.siteSelectedCalled)
            case .error:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                XCTAssertTrue(presenter.viewDidLoadCalled)
            }
        }
    }

    func testDidSelectRowRoutesWhenErrorIsTrue() {
        let cellTypes = SitesCellTypes.filteredCellTypes(viewModel: nil, showError: true)
        sut.viewController?.presenterErrorView()

        for segmentIndex in 0 ..< cellTypes.count {
            let indexPath = IndexPath(row: .zero, section: segmentIndex)
            let cellSection = cellTypes[segmentIndex]
            switch cellSection {
            case .header:
                break
            case .sites:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                XCTAssertTrue(presenter.siteSelectedCalled)
            case .error:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                XCTAssertTrue(presenter.viewDidLoadCalled)
            }
        }
    }
}
