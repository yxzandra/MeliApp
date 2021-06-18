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
        super.tearDown()

        viewController = nil
        sut = nil
        presenter = nil
    }
    
    func testNumberOfRowsReturnsZeroWhenViewModelIsNil() {
        let tableView = findTableView(parentView: viewController.view)
        let numberOfRows = sut.tableView(tableView, numberOfRowsInSection: 0)

        XCTAssertNil(viewController.viewModel)
        XCTAssertEqual(numberOfRows, 0)
    }
    
    func testCellIsEmptyWhenViewModelIsNil() {
        let tableView = findTableView(parentView: viewController.view)
        let indexPath = IndexPath(row: 0, section: 0)

        let cell = sut.tableView(tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }
    
    func testCellTypeIsCorrect() {
        let cellTypes = SitesCellTypes.default
        let viewModel = SiteViewModel.mocked()
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
