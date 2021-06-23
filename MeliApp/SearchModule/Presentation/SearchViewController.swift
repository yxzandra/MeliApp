import Foundation
import UIKit

class SearchViewController: UIViewController {
    internal var presenter: SearchPresenterProtocol?
    
    private typealias Constants = SearchViewConstants
    private var mainDispatchQueue: DispatchQueue?
    private var delegate: SearchDelegate?
    private var dataSource: SearchDataSource?
    
    let loadIndicatorView = UIActivityIndicatorView(style: .large)
    let tableView = UITableView()
    var idSite = String()
    var viewModel: [SearchViewModel]?
    var showError: Bool = false
    
    convenience init(
        mainDispatchQueue: DispatchQueue = DispatchQueue.main,
        dataSource: SearchDataSource,
        delegate: SearchDelegate,
        presenter: SearchPresenterProtocol
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
        presenter?.viewDidLoad(idSite: idSite)
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
        tableView.register(UINib(nibName: Constants.NibCell.nibSearchCell, bundle: nil), forCellReuseIdentifier: Constants.NibCell.nibSearchCell)
        tableView.register(UINib(nibName: Constants.NibCell.nibItemSearchCell, bundle: nil), forCellReuseIdentifier: Constants.NibCell.nibItemSearchCell)
        tableView.register(UINib(nibName: Constants.NibCell.nibErrorSearchCell, bundle: nil), forCellReuseIdentifier: Constants.NibCell.nibErrorSearchCell)
    }
    
    private func prepareActivityIndicator() {
        self.loadIndicatorView.color = .titleColor
        self.view.addAutoLayout(subview: self.loadIndicatorView)
        Layout.center(view: loadIndicatorView, in: self.view)
    }
}

extension SearchViewController: SearchViewProtocol {
    func presenterErrorView() {
        showError = true
        viewModel = nil
        self.tableView.reloadData()
    }
    
    func presenterPushDataView(receivedData: [SearchViewModel]?) {
        self.showError = false
        self.viewModel = receivedData
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
}
