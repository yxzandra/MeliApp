import Foundation

class SitesInteractor: SitesInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: SitesInteractorOutputProtocol?
    var localDatamanager: SitesLocalDataManagerInputProtocol?
    var remoteDatamanager: SitesRemoteDataManagerInputProtocol?
    
    func getSites() {
        remoteDatamanager?.externalGetData()
    }

}

extension SitesInteractor: SitesRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
