import Foundation

class DetailInteractor: DetailInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: DetailInteractorOutputProtocol?
    var remoteDatamanager: DetailRemoteDataManagerInputProtocol?
    let mapper = DetailMapper()
    
    convenience init(
        presenter: DetailInteractorOutputProtocol,
        remoteDatamanager: DetailRemoteDataManagerInputProtocol
    ) {
        self.init()
        self.presenter = presenter
        self.remoteDatamanager = remoteDatamanager
    }

    func getDetailItem(idItem: String) {
        remoteDatamanager?.externalDetailItem(idItem: idItem)
    }

    func getDescriptionItem(idItem: String) {
        remoteDatamanager?.externalDescriptionItem(idItem: idItem)
    }
}

extension DetailInteractor: DetailRemoteDataManagerOutputProtocol {
    func returnDescription(data: Description) {
        presenter?.interactorPushDescriptionPresenter(receivedData: data.plainText)
    }
    
    func errorDescription() {
        presenter?.interactorErrorDescriptionPresenter()
    }
    
    func returnData(data: Detail) {
        let viewModel = mapper.reverseMap(value: data)
        presenter?.interactorPushDataPresenter(receivedData: viewModel)
    }
    
    func errorData() {
        presenter?.interactorErrorDataPresenter()
    }
}
