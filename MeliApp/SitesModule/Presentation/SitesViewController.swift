import UIKit

class SitesViewController: UIViewController {
    typealias Constants = SitesViewConstants
    internal var presenter: SitesPresenterProtocol?
    
    private let loadIndicatorView = UIActivityIndicatorView(style: .large)
    private let tableView = UITableView()
    private let retryButton = UIButton()
    private var delegate: SitesDelegate?
    private var dataSource: SitesDataSource?
    
    var viewModel: [SiteViewModel]?
    
    convenience init(
        dataSource: SitesDataSource,
        delegate: SitesDelegate,
        presenter: SitesPresenterProtocol
    ) {
        self.init()
        dataSource.viewController = self
        delegate.viewController = self
        self.dataSource = dataSource
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareTableView()
        registerCells()
        prepareActivityIndicator()
        prepareRetryButton()
        presenter?.viewDidLoad()
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
        tableView.register(UINib(nibName: Constants.nibTitleSiteCell, bundle: nil), forCellReuseIdentifier: Constants.nibTitleSiteCell)
        tableView.register(UINib(nibName: Constants.nibItemSiteCell, bundle: nil), forCellReuseIdentifier: Constants.nibItemSiteCell)
    }
    
    private func prepareActivityIndicator() {
        self.loadIndicatorView.center = self.view.center
        self.loadIndicatorView.color = .titleColor
        self.view.addSubview(self.loadIndicatorView)
    }
    
    private func prepareRetryButton() {
        self.retryButton.isHidden = true
        self.retryButton.center = self.view.center
        self.retryButton.setTitle(Constants.titleRetryButton, for: .normal)
        self.retryButton.setTitleColor(.titleColor, for: .normal)
        self.retryButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.retryButton)
        Layout.center(view: retryButton, in: self.view)
        
        self.retryButton.addTarget(self, action: #selector(retryTouchUpInside), for: .touchUpInside)
    }
    
    @objc func retryTouchUpInside() {
        presenter?.viewDidLoad()
    }
}

extension SitesViewController: SitesViewProtocol {
    func showMessageError(message: String) {
        self.showToast(message: message, seconds: 5.0)
    }
    
    func hideTableView(isHide: Bool) {
        DispatchQueue.main.async {
            self.tableView.isHidden = isHide
        }
    }
    
    func hideRetryButton(isHide: Bool) {
        DispatchQueue.main.async {
            self.retryButton.isHidden = isHide
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
    
    func presenterPushDataView(receivedData: [SiteViewModel]) {
        self.viewModel = receivedData
        tableView.reloadData()
    }
}
