import XCTest
@testable import MeliApp

class DetailDelegateTests: XCTestCase {
    var sut: DetailDelegate!
    var tableView: UITableView!
    var viewController: DetailViewControllerMock!
    
    override func setUp() {
        super.setUp()
        sut = DetailDelegate()
        viewController = DetailViewControllerMock()
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

    func testDidSelectRowRoutesWhenAppropiate() {
        let cellTypes = DetailCellTypes.default
        let viewModel = DetailViewModel.mocked()
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
