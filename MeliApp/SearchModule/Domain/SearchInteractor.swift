import Foundation

class SearchInteractor: SearchInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: SearchInteractorOutputProtocol?
    var localDatamanager: SearchLocalDataManagerInputProtocol?
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol?
    let mapper = SearchMapper()
    
    convenience init(
        presenter: SearchInteractorOutputProtocol,
        localDatamanager: SearchLocalDataManagerInputProtocol,
        remoteDatamanager: SearchRemoteDataManagerInputProtocol
    ) {
        self.init()
        self.presenter = presenter
        self.localDatamanager = localDatamanager
        self.remoteDatamanager = remoteDatamanager
    }

    func searchItem(item: String, idSite: String) {
        remoteDatamanager?.externalSearchItem(item: item, idSite: idSite)
    }
}

extension SearchInteractor: SearchRemoteDataManagerOutputProtocol {
    func returnData(data: Search) {
        let viewModel = mapper.reverseMap(values: data.results)
        if viewModel.isEmpty {
            presenter?.interactorErrorDataPresenter()
        } else {
            presenter?.interactorPushDataPresenter(receivedData: viewModel)
        }
    }
    
    func errorData() {
        presenter?.interactorErrorDataPresenter()
    }
}
