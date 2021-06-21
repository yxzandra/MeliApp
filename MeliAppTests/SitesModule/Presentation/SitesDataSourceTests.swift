import XCTest
@testable import MeliApp

class SitesDataSourceTests: XCTestCase {
    var sut: SitesDataSource!
    var tableView: UITableView!
    var presenter: SitesPresenter!
    var viewController: SitesViewController!
    
    override func setUp() {
        super.setUp()

        sut = SitesDataSource()
        presenter = SitesPresenter()
        viewController = SitesViewController(
            dataSource: sut,
            delegate: SitesDelegate(),
            presenter: presenter
        )
        tableView = UITableView()
        viewController.presenter = presenter
        sut.viewController = viewController
        tableView.dataSource = sut
    }
    
    override func tearDown() {
        tableView = nil
        viewController = nil
        sut = nil
        presenter = nil
        super.tearDown()
    }
    
    func testNumberOfRowsReturnsCountViewModelSuccess() {
        let viewModel = SiteViewModel.mocked()
        let tableView = findTableView(parentView: viewController.view)
        let cellTypes = SitesCellTypes.filteredCellTypes(viewModel: viewModel, showError: false)
        viewController.presenterPushDataView(receivedData: viewModel)
        
        for numSection in 0 ..< cellTypes.count {
            let numberOfRows = sut.tableView(tableView, numberOfRowsInSection: numSection)
            let section = cellTypes[numSection]
            
            switch section {
            case .header:
                XCTAssertEqual(numberOfRows, 1)
            case .sites:
                XCTAssertEqual(numberOfRows, viewModel.count)
            case .error:
                XCTAssertEqual(numberOfRows, 0)
            }
            XCTAssertNotNil(viewController.viewModel)
            XCTAssertFalse(viewController.showError)
        }
    }
    
    func testNumberOfRowsReturnsOneWhenErrorIsTrue() {
        let tableView = findTableView(parentView: viewController.view)
        let cellTypes = SitesCellTypes.filteredCellTypes(viewModel: nil, showError: true)
        viewController.presenterErrorView()
        
        for numSection in 0 ..< cellTypes.count {
            let numberOfRows = sut.tableView(tableView, numberOfRowsInSection: numSection)
            let section = cellTypes[numSection]
            
            switch section {
            case .header, .error:
                XCTAssertEqual(numberOfRows, 1)
            case .sites:
                XCTAssertEqual(numberOfRows, 0)
            }
            XCTAssertNil(viewController.viewModel)
            XCTAssertTrue(viewController.showError)
        }
    }
    
    func testCellIsEmptyWhenViewModelIsNil() {
        let tableView = findTableView(parentView: viewController.view)

        let cellTypes = SitesCellTypes.default
        
        for numSection in 0 ..< cellTypes.count {
            let indexPath = IndexPath(row: 0, section: numSection)
            let cell = sut.tableView(tableView, cellForRowAt: indexPath)
            XCTAssertNotNil(cell)
        }
    }
    
    func testCellTypeIsCorrectWhenViewModelNotNil() {
        let viewModel = SiteViewModel.mocked()
        let cellTypes = SitesCellTypes.filteredCellTypes(viewModel: viewModel, showError: false)
        let tableView = findTableView(parentView: viewController.view)

        viewController.presenterPushDataView(receivedData: viewModel)

        for numSection in 0 ..< cellTypes.count {
            let section = cellTypes[numSection]
            let indexPath = IndexPath(row: 0, section: numSection)
            switch section {
            case .header:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: TitleSiteCell.self
                )
            case .sites:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: ItemSiteCell.self
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
        let cellTypes = SitesCellTypes.filteredCellTypes(viewModel: nil, showError: true)
        let tableView = findTableView(parentView: viewController.view)

        viewController.presenterErrorView()

        for numSection in 0 ..< cellTypes.count {
            let section = cellTypes[numSection]
            let indexPath = IndexPath(row: 0, section: numSection)
            switch section {
            case .header:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: TitleSiteCell.self
                )
            case .sites:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: UITableViewCell.self
                )
            case .error:
                assertCellIsOfType(
                    tableView: tableView,
                    indexPath: indexPath,
                    cellType: ErrorSiteCell.self
                )
            }        }
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
