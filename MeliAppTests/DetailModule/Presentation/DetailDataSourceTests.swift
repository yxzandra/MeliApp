import XCTest
@testable import MeliApp

class DetailDatasourceTests: XCTestCase {
    var sut: DetailDataSource!
    var tableView: UITableView!
    var presenter: DetailPresenter!
    var viewController: DetailViewController!
    
    override func setUp() {
        super.setUp()

        sut = DetailDataSource()
        presenter = DetailPresenter()
        viewController = DetailViewController(
            dataSource: sut,
            delegate: DetailDelegate(),
            presenter: presenter
        )
        tableView = UITableView()
        viewController.presenter = presenter
        sut.viewController = viewController
        tableView.dataSource = sut
    }
    
    override func tearDown() {
        viewController = nil
        sut = nil
        presenter = nil
        tableView = nil
        super.tearDown()
    }
    
    func testNumberOfRowsReturnsOneWhenViewModelIsNil() {
        let tableView = findTableView(parentView: viewController.view)
        let cellTypes = DetailCellTypes.default
        
        for numSection in 0 ..< cellTypes.count {
            let numberOfRows = sut.tableView(tableView, numberOfRowsInSection: numSection)
            
            XCTAssertEqual(numberOfRows, 3)
            XCTAssertNil(viewController.viewModel)
            XCTAssertFalse(viewController.showError)
        }
    }
    
    func testCellIsEmptyWhenViewModelIsNil() {
        let tableView = findTableView(parentView: viewController.view)

        let cellTypes = DetailCellTypes.default
        
        for numSection in 0 ..< cellTypes.count {
            let indexPath = IndexPath(row: 0, section: numSection)
            let cell = sut.tableView(tableView, cellForRowAt: indexPath)
            XCTAssertNotNil(cell)
        }
    }
    
    func testCellTypeIsCorrectWhenViewModelNotNil() {
        let viewModel = DetailViewModel.mocked()
        let cellTypes = DetailCellTypes.default
        let tableView = findTableView(parentView: viewController.view)

        viewController.presenterPushDataView(receivedData: viewModel)

        for numRow in 0 ..< cellTypes.count {
            let row = cellTypes[numRow]
            let indexPath = IndexPath(row: numRow, section: .zero)
            switch row {
            case .carousel:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: CarouselDetailCell.self
                )
            case .header:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: HeaderDetailCell.self
                )
            case .description:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: DescriptionDetailCell.self
                )
            }
        }
    }
    
    func testCellTypeIsCorrectWhenErrorIsTrue() {
        let cellTypes = DetailCellTypes.default
        let tableView = findTableView(parentView: viewController.view)

        viewController.presenterErrorDataView()

        for numSection in 0 ..< cellTypes.count {
            let indexPath = IndexPath(row: 0, section: numSection)
            assertCellIsOfType(
                tableView: tableView,
                indexPath: indexPath,
                cellType: UITableViewCell.self
            )
        }
    }
    
    // MARK: - Helpers
    private func findTableView(parentView: UIView) -> UITableView {
        let tableViews = parentView.subviews.filter { $0 is UITableView }
        let tableView = tableViews.first as? UITableView

        XCTAssertNotNil(tableView)
        return tableView!
    }
    
    private func assertCellIsOfType<T: UITableViewCell>(
        tableView: UITableView,
        indexPath: IndexPath,
        cellType _: T.Type
    ) {
        let cell = sut.tableView(tableView, cellForRowAt: indexPath)

        let tableViewCellClassName = String(describing: T.classForCoder())
        let cellClassName = String(describing: cell.classForCoder)

        XCTAssertTrue(cell is T)
        XCTAssertEqual(cellClassName, tableViewCellClassName)
    }
}
