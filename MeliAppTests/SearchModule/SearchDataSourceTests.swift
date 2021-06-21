import XCTest
@testable import MeliApp

class SearchDataSourceTests: XCTestCase {
    var sut: SearchDataSource!
    var tableView: UITableView!
    var presenter: SearchPresenter!
    var viewController: SearchViewController!
    
    override func setUp() {
        super.setUp()

        sut = SearchDataSource()
        presenter = SearchPresenter()
        viewController = SearchViewController(
            dataSource: sut,
            delegate: SearchDelegate(),
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
        let cellTypes = SearchCellTypes.default
        
        for numSection in 0 ..< cellTypes.count {
            let numberOfRows = sut.tableView(tableView, numberOfRowsInSection: numSection)
            let section = cellTypes[numSection]
            
            switch section {
            case .search:
                XCTAssertEqual(numberOfRows, 1)
            case .items, .error:
                XCTAssertEqual(numberOfRows, 0)
            }
            XCTAssertNil(viewController.viewModel)
            XCTAssertFalse(viewController.showError)
        }
    }
    
    func testCellIsEmptyWhenViewModelIsNil() {
        let tableView = findTableView(parentView: viewController.view)

        let cellTypes = SearchCellTypes.default
        
        for numSection in 0 ..< cellTypes.count {
            let indexPath = IndexPath(row: 0, section: numSection)
            let cell = sut.tableView(tableView, cellForRowAt: indexPath)
            XCTAssertNotNil(cell)
        }
    }
    
    func testCellTypeIsCorrectWhenViewModelNotNil() {
        let viewModel = SearchViewModel.mocked()
        let cellTypes = SearchCellTypes.filteredCellTypes(viewModel: viewModel, showError: false)
        let tableView = findTableView(parentView: viewController.view)

        viewController.presenterPushDataView(receivedData: viewModel)

        for numSection in 0 ..< cellTypes.count {
            let section = cellTypes[numSection]
            let indexPath = IndexPath(row: 0, section: numSection)
            switch section {
            case .search:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: SearchCell.self
                )
            case .items:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: ItemSearchCell.self
                )
            case .error:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: UITableViewCell.self
                )
            }
        }
    }
    
    func testCellTypeIsCorrectWhenErrorIsTrue() {
        let cellTypes = SearchCellTypes.filteredCellTypes(viewModel: nil, showError: true)
        let tableView = findTableView(parentView: viewController.view)

        viewController.presenterErrorView()

        for numSection in 0 ..< cellTypes.count {
            let section = cellTypes[numSection]
            let indexPath = IndexPath(row: 0, section: numSection)
            switch section {
            case .search:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: SearchCell.self
                )
            case .items:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: UITableViewCell.self
                )
            case .error:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: ErrorSearchCell.self
                )
            }
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
