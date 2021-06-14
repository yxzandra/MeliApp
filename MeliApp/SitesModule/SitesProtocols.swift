import UIKit

protocol SitesViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SitesPresenterProtocol? { get set }
    
    func presenterPushDataView(receivedData: [SiteViewModel])
    func loadActivity()
    func stopAndHideActivity()
    func hideTableView(isHide: Bool)
}

protocol SitesWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createSitesModule() -> UIViewController
}

protocol SitesPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SitesViewProtocol? { get set }
    var interactor: SitesInteractorInputProtocol? { get set }
    var wireFrame: SitesWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol SitesInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorPushDataPresenter(receivedData: [SiteViewModel])
}

protocol SitesInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SitesInteractorOutputProtocol? { get set }
    var localDatamanager: SitesLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SitesRemoteDataManagerInputProtocol? { get set }
    
    func getSites()
}

protocol SitesDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol SitesRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SitesRemoteDataManagerOutputProtocol? { get set }
    
    func externalGetData()
}

protocol SitesRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func returnData(sites: [Site])
}

protocol SitesLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
