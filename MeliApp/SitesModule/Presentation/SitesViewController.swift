import UIKit

class SitesViewController: UIViewController {
    internal var presenter: SitesPresenterProtocol?
    
    private typealias Constants = SitesViewConstants
    private var mainDispatchQueue: DispatchQueue?
    private var delegate: SitesDelegate?
    private var dataSource: SitesDataSource?
    
    let tableView = UITableView()
    let loadIndicatorView = UIActivityIndicatorView(style: .large)
    var viewModel: [SiteViewModel]?
    var showError: Bool = false
    
    convenience init(
        mainDispatchQueue: DispatchQueue = DispatchQueue.main,
        dataSource: SitesDataSource,
        delegate: SitesDelegate,
        presenter: SitesPresenterProtocol
    ) {
        self.init()
        dataSource.viewController = self
        delegate.viewController = self
        self.dataSource = dataSource
        self.delegate = delegate
        self.presenter = presenter
        self.mainDispatchQueue = mainDispatchQueue
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareTableView()
        registerCells()
        prepareActivityIndicator()
        presenter?.viewDidLoad()
    }

    private func prepareView() {
        self.view.backgroundColor = .backgroundColor
        self.navigationItem.title = Constants.titleView
    }

    private func prepareTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        self.view.addAutoLayout(subview: tableView)
        Layout.pin(view: tableView, to: view)
        
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.alwaysBounceHorizontal = false
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: Constants.NibCell.nibTitleSiteCell, bundle: nil), forCellReuseIdentifier: Constants.NibCell.nibTitleSiteCell)
        tableView.register(UINib(nibName: Constants.NibCell.nibItemSiteCell, bundle: nil), forCellReuseIdentifier: Constants.NibCell.nibItemSiteCell)
        tableView.register(UINib(nibName: Constants.NibCell.nibErrorSiteCell, bundle: nil), forCellReuseIdentifier: Constants.NibCell.nibErrorSiteCell)
    }
    
    private func prepareActivityIndicator() {
        self.loadIndicatorView.color = .titleColor
        self.view.addAutoLayout(subview: self.loadIndicatorView)
        Layout.center(view: loadIndicatorView, in: self.view)
    }
}

extension SitesViewController: SitesViewProtocol {
    func presenterErrorView() {
        showError = true
        viewModel = nil
        self.tableView.reloadData()
    }
    
    func hideTableView(isHide: Bool) {
        mainDispatchQueue?.async {
            self.tableView.isHidden = isHide
        }
    }
    
    func loadActivity() {
        mainDispatchQueue?.async {
            self.loadIndicatorView.startAnimating()
        }
    }

    func stopAndHideActivity() {
        mainDispatchQueue?.async {
            self.loadIndicatorView.stopAnimating()
            self.loadIndicatorView.hidesWhenStopped = true
        }
    }
    
    func presenterPushDataView(receivedData: [SiteViewModel]) {
        self.showError = false
        self.viewModel = receivedData
        tableView.reloadData()
    }
}
