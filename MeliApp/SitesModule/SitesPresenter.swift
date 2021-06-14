import Foundation

class SitesPresenter  {
    
    // MARK: Properties
    weak var view: SitesViewProtocol?
    var interactor: SitesInteractorInputProtocol?
    var wireFrame: SitesWireFrameProtocol?
    
}

extension SitesPresenter: SitesPresenterProtocol {
    func viewDidLoad() {
        interactor?.getSites()
        view?.loadActivity()
        view?.hideTableView(isHide: true)
    }
}

extension SitesPresenter: SitesInteractorOutputProtocol {
    func interactorPushDataPresenter(receivedData: [SiteViewModel]) {
        view?.stopAndHideActivity()
        view?.presenterPushDataView(receivedData: receivedData)
        view?.hideTableView(isHide: false)
    }
    
}
