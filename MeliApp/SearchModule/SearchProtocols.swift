import Foundation
import UIKit

protocol SearchViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SearchPresenterProtocol? { get set }
    func loadActivity()
    func stopAndHideActivity()
    func hideTableView(isHide: Bool)
    func presenterPushDataView(receivedData: [SearchViewModel]?)
    func presenterErrorView()
}

protocol SearchWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createSearchModule(with data: String) -> UIViewController
    func presentViewDetail(from view: SearchViewProtocol, idItem: String)
}

protocol SearchPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorInputProtocol? { get set }
    var wireFrame: SearchWireFrameProtocol? { get set }
    
    func viewDidLoad(idSite: String)
    func searchItem(item: String)
    func itemSelected(idItem: String)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorErrorDataPresenter()
    func interactorPushDataPresenter(receivedData: [SearchViewModel])
}

protocol SearchInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SearchInteractorOutputProtocol? { get set }
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol? { get set }
    
    func searchItem(item: String, idSite: String)
}

protocol SearchRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol? { get set }
    func externalSearchItem(item: String, idSite: String)
}

protocol SearchRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func returnData(data: Search)
    func errorData()
}
