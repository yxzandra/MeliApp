import Foundation

class SitesInteractor: SitesInteractorInputProtocol {
    weak var presenter: SitesInteractorOutputProtocol?
    var localDatamanager: SitesLocalDataManagerInputProtocol?
    var remoteDatamanager: SitesRemoteDataManagerInputProtocol?
    let mapper = SiteMapper()
    
    convenience init(
        presenter: SitesInteractorOutputProtocol,
        localDatamanager: SitesLocalDataManagerInputProtocol,
        remoteDatamanager: SitesRemoteDataManagerInputProtocol
    ) {
        self.init()
        self.presenter = presenter
        self.localDatamanager = localDatamanager
        self.remoteDatamanager = remoteDatamanager
    }
    
    func getSites() {
        remoteDatamanager?.externalGetData()
    }
    
    func siteSelected(idSide: String) {
        localDatamanager?.internalSaveSite(idSite: idSide)
    }
}

extension SitesInteractor: SitesRemoteDataManagerOutputProtocol {
    func errorData(statusCode: Int, error: Error) {
        presenter?.interactorErrorDataPresenter(statusCode: statusCode, error: error)
    }
    
    func returnData(sites: [Site]) {
        let viewModel = mapper.reverseMap(values: sites)
        presenter?.interactorPushDataPresenter(receivedData: viewModel)
    }
}
