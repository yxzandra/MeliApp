import XCTest
@testable import MeliApp

class DetailInteractorInputMock: DetailInteractorInputProtocol {
    var presenter: DetailInteractorOutputProtocol?
    var remoteDatamanager: DetailRemoteDataManagerInputProtocol?
    
    var getDetailItemCalled = false
    var getDescriptionItemCalled = false
    
    func getDetailItem(idItem: String) {
        getDetailItemCalled = true
    }
    
    func getDescriptionItem(idItem: String) {
        getDescriptionItemCalled = true
    }
}
