import Foundation
import UIKit

class SearchViewController: UIViewController {
    typealias Constants = SearchViewConstants
    internal var presenter: SearchPresenterProtocol?
    
    private let loadIndicatorView = UIActivityIndicatorView(style: .large)
    private let tableView = UITableView()
    private var delegate: SearchDelegate?
    private var dataSource: SearchDataSource?
    
    var idSite = String()
    var viewModel: [SearchViewModel]?
    var showError: Bool = false
    
    convenience init(
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
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
        self.loadIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.loadIndicatorView.color = .titleColor
        self.view.addSubview(self.loadIndicatorView)
        
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
        DispatchQueue.main.async {
            self.tableView.isHidden = isHide
        }
    }
    
    func loadActivity() {
        DispatchQueue.main.async {
            self.loadIndicatorView.startAnimating()
        }
    }

    func stopAndHideActivity() {
        DispatchQueue.main.async {
            self.loadIndicatorView.stopAnimating()
            self.loadIndicatorView.hidesWhenStopped = true
        }
    }
}
