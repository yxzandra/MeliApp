import Foundation

class SitesInteractor: SitesInteractorInputProtocol {
    weak var presenter: SitesInteractorOutputProtocol?
    var localDatamanager: SitesLocalDataManagerInputProtocol?
    var remoteDatamanager: SitesRemoteDataManagerInputProtocol?
    let mapper = SiteMapper()
    
    func getSites() {
        remoteDatamanager?.externalGetData()
    }
    
    func siteSelected(idSide: String) {
        localDatamanager?.internalSaveSite(idSite: idSide)
    }
}

extension SitesInteractor: SitesRemoteDataManagerOutputProtocol {
    func returnData(sites: [Site]) {
        let viewModel = mapper.reverseMap(values: sites)
        presenter?.interactorPushDataPresenter(receivedData: viewModel)
    }
}
