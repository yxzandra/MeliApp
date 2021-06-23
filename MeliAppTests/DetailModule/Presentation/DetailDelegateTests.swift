import XCTest
@testable import MeliApp

class DetailDelegateTests: XCTestCase {
    var sut: DetailDelegate!
    var tableView: UITableView!
    var presenter: DetailPresenterMock!
    var viewController: DetailViewControllerMock!
    
    override func setUp() {
        super.setUp()
        sut = DetailDelegate()
        presenter = DetailPresenterMock()
        viewController = DetailViewControllerMock()
        viewController.presenter = presenter
        tableView = UITableView()
        
        sut.viewController = viewController
        tableView.delegate = sut
    }
    
    override func tearDown() {
        tableView = nil
        viewController = nil
        sut = nil
        super.tearDown()
    }

    func testDidSelectRowRoutesWhenViewModelNotNil() {
        let viewModel = DetailViewModel.mocked()
        let cellTypes = DetailCellTypes.filteredCellTypes(viewModel: viewModel, showError: false)
        sut.viewController?.presenterPushDataView(receivedData: viewModel)

        for segmentIndex in 0 ..< cellTypes.count {
            let indexPath = IndexPath(row: segmentIndex, section: .zero)
            let cellSection = cellTypes[segmentIndex]
            switch cellSection {
            case .carousel, .header:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                break
            case .description:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                XCTAssertTrue(viewController.validateDescriptionCalled)
            case .error:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                XCTAssertTrue(presenter.viewDidLoadCalled)
            }
        }
    }
    
    func testDidSelectRowRoutesWhenShowErrorTrue() {
        let cellTypes = DetailCellTypes.filteredCellTypes(viewModel: nil, showError: true)
        sut.viewController?.presenterErrorDataView()

        for segmentIndex in 0 ..< cellTypes.count {
            let indexPath = IndexPath(row: segmentIndex, section: .zero)
            let cellSection = cellTypes[segmentIndex]
            switch cellSection {
            case .carousel, .header:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                break
            case .description:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                XCTAssertTrue(viewController.validateDescriptionCalled)
            case .error:
                sut.tableView(tableView, didSelectRowAt: indexPath)
                XCTAssertTrue(presenter.viewDidLoadCalled)
            }
        }
    }

    func testTableViewHeightForRowShouldAlwaysReturnAutomaticDimension() {
        let viewModel = DetailViewModel.mocked()
        let expectedHeight = UITableView.automaticDimension
        sut.viewController?.presenterPushDataView(receivedData: viewModel)

        let cellSection = DetailCellTypes.default.count

        for segmentIndex in 0 ..< cellSection {
            let indexPath = IndexPath(row: 0, section: segmentIndex)
            let height = sut.tableView(tableView, heightForRowAt: indexPath)
            XCTAssertEqual(height, expectedHeight)
        }
    }
}
