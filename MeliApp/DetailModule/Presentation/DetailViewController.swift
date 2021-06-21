import UIKit

class DetailViewController: UIViewController {

    // MARK: Properties
    internal var presenter: DetailPresenterProtocol?
    
    private var mainDispatchQueue: DispatchQueue?
    private var delegate: DetailDelegate?
    private var dataSource: DetailDataSource?

    
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
    }
}

extension DetailViewController: DetailViewProtocol {
    // TODO: implement view output methods
}
