import UIKit

class SitesView: UIViewController {
    internal var presenter: SitesPresenterProtocol?
    
    private let tableView = UITableView()
    private let loadIndicatorView = UIActivityIndicatorView(style: .large)
    private var delegate: SitesDelegate?
    private var dataSource: SitesDataSource?
    
    var viewModel: [SitesViewModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
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
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        Layout.pin(view: tableView, to: view)
        
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 14, left: .zero, bottom: 14, right: .zero)
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
    
    func presenterPushDataView(receivedData: [SitesViewModel]) {
        self.viewModel = receivedData
        tableView.reloadData()
    }
}
