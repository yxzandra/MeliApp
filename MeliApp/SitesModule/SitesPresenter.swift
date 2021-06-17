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
        view?.hideRetryButton(isHide: true)
    }
    
    func siteSelected(site: SiteViewModel) {
        interactor?.siteSelected(idSide: site.id)
        wireFrame?.presentViewSearch(from: view!, idSide: site.id)
    }
}

extension SitesPresenter: SitesInteractorOutputProtocol {
    func interactorErrorDataPresenter(statusCode: Int, error: Error) {
        let message = String(
            format: SitesViewConstants.formatError,
            error.error,
            statusCode,
            error.message
        )
        view?.stopAndHideActivity()
        view?.showMessageError(message: message)
        view?.hideRetryButton(isHide: false)
    }
    
    func interactorPushDataPresenter(receivedData: [SiteViewModel]) {
        view?.stopAndHideActivity()
        view?.presenterPushDataView(receivedData: receivedData)
        view?.hideTableView(isHide: false)
    }
}
