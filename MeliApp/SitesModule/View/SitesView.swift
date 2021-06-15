import UIKit

class SitesView: UIViewController {
    internal var presenter: SitesPresenterProtocol?
    
    private let tableView = UITableView()
    private let loadIndicatorView = UIActivityIndicatorView(style: .large)
    private var delegate: SitesDelegate?
    private var dataSource: SitesDataSource?
    
    var viewModel: [SiteViewModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        registerCells()
        prepareActivityIndicator()
        presenter?.viewDidLoad()
    }
    
    private func prepareTableView() {
        self.view.backgroundColor = .backgroundColor
        self.navigationItem.title = "Paises Asociados"
        self.dataSource = SitesDataSource()
        self.delegate = SitesDelegate()
        dataSource?.viewController = self
        delegate?.viewController = self
        
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
        tableView.register(UINib(nibName: "TitleSiteCell", bundle: nil), forCellReuseIdentifier: "TitleSiteCell")
        tableView.register(UINib(nibName: "ItemSiteCell", bundle: nil), forCellReuseIdentifier: "ItemSiteCell")
    }
    
    private func prepareActivityIndicator() {
        self.loadIndicatorView.center = self.view.center
        self.loadIndicatorView.color = .titleColor
        self.view.addSubview(self.loadIndicatorView)
    }
}

extension SitesView: SitesViewProtocol {
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
    
    func presenterPushDataView(receivedData: [SiteViewModel]) {
        self.viewModel = receivedData
        tableView.reloadData()
    }
}
