import Foundation
import UIKit

class SearchViewController: UIViewController {

    // MARK: Properties
    var presenter: SearchPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchViewController: SearchViewProtocol {
    // TODO: implement view output methods
}
