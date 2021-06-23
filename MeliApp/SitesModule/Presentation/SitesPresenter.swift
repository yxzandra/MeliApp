import Foundation

class SitesPresenter  {
    // MARK: Properties
    weak var view: SitesViewProtocol?
    var interactor: SitesInteractorInputProtocol?
    var wireFrame: SitesWireFrameProtocol?
    
    convenience init(
        view: SitesViewProtocol,
        interactor: SitesInteractorInputProtocol,
        wireFrame: SitesWireFrameProtocol
    ) {
        self.init()
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension SitesPresenter: SitesPresenterProtocol {
    func viewDidLoad() {
        view?.loadActivity()
        view?.hideTableView(isHide: true)
        interactor?.getSites()
    }
    
    func siteSelected(site: SiteViewModel) {
        interactor?.siteSelected(idSide: site.id)
        wireFrame?.presentViewSearch(from: view!, idSide: site.id)
    }
}

extension SitesPresenter: SitesInteractorOutputProtocol {
    func interactorErrorDataPresenter() {
        view?.stopAndHideActivity()
        view?.hideTableView(isHide: false)
        view?.presenterErrorView()
    }
    
    func interactorPushDataPresenter(receivedData: [SiteViewModel]) {
        view?.stopAndHideActivity()
        view?.presenterPushDataView(receivedData: receivedData)
        view?.hideTableView(isHide: false)
    }
}
