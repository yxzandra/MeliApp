import Foundation

class SitesInteractor: NSObject {
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
    
    private func sortSites(siteList: [SiteViewModel]) -> [SiteViewModel] {
        if let idSite = localDatamanager?.getSiteSaved(), let index = siteList.firstIndex(where: {$0.id == idSite}) {
            var siteListResult = siteList
            let element = siteListResult.remove(at: index)
            siteListResult.insert(element, at: .zero)
            return siteListResult
        }
        return siteList
    }
}

extension SitesInteractor: SitesInteractorInputProtocol {
    func getSites() {
        remoteDatamanager?.externalGetData()
    }
    
    func siteSelected(idSide: String) {
        localDatamanager?.internalSaveSite(idSite: idSide)
    }
}

extension SitesInteractor: SitesRemoteDataManagerOutputProtocol {
    func errorData() {
        presenter?.interactorErrorDataPresenter()
    }
    
    func returnData(sites: [Site]) {
        let viewModel = mapper.reverseMap(values: sites)
        let viewModelSorted = sortSites(siteList: viewModel)
        presenter?.interactorPushDataPresenter(receivedData: viewModelSorted)
    }
}
