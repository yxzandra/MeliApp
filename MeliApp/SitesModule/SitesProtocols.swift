import UIKit

protocol SitesViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SitesPresenterProtocol? { get set }
    
    func presenterPushDataView(receivedData: [SiteViewModel])
    func loadActivity()
    func stopAndHideActivity()
    func hideTableView(isHide: Bool)
    func presenterErrorView()
}

protocol SitesWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createSitesModule() -> UIViewController
    func presentViewSearch(from view: SitesViewProtocol, idSide: String)
}

protocol SitesPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SitesViewProtocol? { get set }
    var interactor: SitesInteractorInputProtocol? { get set }
    var wireFrame: SitesWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func siteSelected(site: SiteViewModel)
}

protocol SitesInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorPushDataPresenter(receivedData: [SiteViewModel])
    func interactorErrorDataPresenter()
}

protocol SitesInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SitesInteractorOutputProtocol? { get set }
    var localDatamanager: SitesLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SitesRemoteDataManagerInputProtocol? { get set }
    
    func getSites()
    func siteSelected(idSide: String)
}

protocol SitesRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SitesRemoteDataManagerOutputProtocol? { get set }
    
    func externalGetData()
}

protocol SitesRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func returnData(sites: [Site])
    func errorData()
}

protocol SitesLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
    func internalSaveSite(idSite: String)
    func getSiteSaved() -> String?
}
