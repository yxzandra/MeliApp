import Foundation
import UIKit

protocol SearchViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SearchPresenterProtocol? { get set }
}

protocol SearchWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createSearchModule(with data: String) -> UIViewController
}

protocol SearchPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorInputProtocol? { get set }
    var wireFrame: SearchWireFrameProtocol? { get set }
    
    func searchItem(item: String)
}

protocol SearchInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol SearchInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SearchInteractorOutputProtocol? { get set }
    var localDatamanager: SearchLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol? { get set }
}

protocol SearchDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol SearchRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol? { get set }
}

protocol SearchRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol SearchLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
