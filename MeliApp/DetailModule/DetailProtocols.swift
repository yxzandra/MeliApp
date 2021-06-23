import Foundation
import UIKit

protocol DetailViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: DetailPresenterProtocol? { get set }
    
    func loadActivity()
    func stopAndHideActivity()
    func hideTableView(isHide: Bool)
    func presenterPushDataView(receivedData: DetailViewModel)
    func presenterPushDetailDataView(receivedData: String)
    func presenterErrorDataView()
    func presenterErrorDescriptionView()
}

protocol DetailWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createDetailModule(with data: String) -> UIViewController
}

protocol DetailPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorInputProtocol? { get set }
    var wireFrame: DetailWireFrameProtocol? { get set }
    
    func viewDidLoad(idItem: String)
    func getDetailDescription(idItem: String)
}

protocol DetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorErrorDataPresenter()
    func interactorErrorDescriptionPresenter()
    func interactorPushDataPresenter(receivedData: DetailViewModel)
    func interactorPushDescriptionPresenter(receivedData: String)
}

protocol DetailInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: DetailInteractorOutputProtocol? { get set }
    var remoteDatamanager: DetailRemoteDataManagerInputProtocol? { get set }
    
    func getDetailItem(idItem: String)
    func getDescriptionItem(idItem: String)
}

protocol DetailRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: DetailRemoteDataManagerOutputProtocol? { get set }

    func externalDetailItem(idItem: String)
    func externalDescriptionItem(idItem: String)
}

protocol DetailRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func returnData(data: Detail)
    func returnDescription(data: Description)
    func errorData()
    func errorDescription()
}
