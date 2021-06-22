import XCTest
@testable import MeliApp

class DetailPresenterMock: DetailPresenterProtocol {
    var view: DetailViewProtocol?
    var interactor: DetailInteractorInputProtocol?
    var wireFrame: DetailWireFrameProtocol?

    var viewDidLoadCalled = false
    var getDetailDescriptionCalled = false
    
    func viewDidLoad(idItem: String) {
        viewDidLoadCalled = true
    }
    
    func getDetailDescription(idItem: String) {
        getDetailDescriptionCalled = true
    }
}
