import Foundation

class SearchInteractor: SearchInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: SearchInteractorOutputProtocol?
    var localDatamanager: SearchLocalDataManagerInputProtocol?
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol?

}

extension SearchInteractor: SearchRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
