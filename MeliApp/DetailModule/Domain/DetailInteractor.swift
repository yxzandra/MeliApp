import Foundation

class DetailInteractor: DetailInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: DetailInteractorOutputProtocol?
    var remoteDatamanager: DetailRemoteDataManagerInputProtocol?
    let mapper = DetailMapper()
    
    func getDetailItem(idItem: String) {
        remoteDatamanager?.externalDetailItem(idItem: idItem)
    }
}

extension DetailInteractor: DetailRemoteDataManagerOutputProtocol {
    func returnData(data: Detail) {
        let viewModel = mapper.reverseMap(value: data)
        presenter?.interactorPushDataPresenter(receivedData: viewModel)
    }
    
    func errorData() {
        presenter?.interactorErrorDataPresenter()
    }
}
