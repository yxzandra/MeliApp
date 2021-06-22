import UIKit

class DetailViewController: UIViewController {
    typealias Constants = DetailViewConstants

    // MARK: Properties
    internal var presenter: DetailPresenterProtocol?
    
    private var mainDispatchQueue: DispatchQueue?
    private var delegate: DetailDelegate?
    private var dataSource: DetailDataSource?

    let loadIndicatorView = UIActivityIndicatorView(style: .large)
    let tableView = UITableView()
    var idItem = String()
    var viewModel: DetailViewModel?
    var showError: Bool = false
    
    convenience init(
        mainDispatchQueue: DispatchQueue = DispatchQueue.main,
        dataSource: DetailDataSource,
        delegate: DetailDelegate,
        presenter: DetailPresenterProtocol
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
        presenter?.viewDidLoad(idItem: idItem)
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
        tableView.register(UINib(nibName: Constants.NibCell.nibCarouselDetailCell, bundle: nil), forCellReuseIdentifier: Constants.NibCell.nibCarouselDetailCell)
    }
    
    private func prepareActivityIndicator() {
        self.loadIndicatorView.color = .titleColor
        self.view.addAutoLayout(subview: self.loadIndicatorView)
        Layout.center(view: loadIndicatorView, in: self.view)
    }
}

extension DetailViewController: DetailViewProtocol {
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
    
    func hideTableView(isHide: Bool) {
        mainDispatchQueue?.async {
            self.tableView.isHidden = isHide
        }
    }
    
    func presenterPushDataView(receivedData: DetailViewModel) {
        self.showError = false
        self.viewModel = receivedData
        self.tableView.reloadData()
    }
    
    func presenterErrorView() {
        showError = true
        viewModel = nil
        self.tableView.reloadData()
    }
}
