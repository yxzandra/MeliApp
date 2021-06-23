import XCTest
@testable import MeliApp

class SearchPresenterMock: SearchPresenterProtocol {
    var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var wireFrame: SearchWireFrameProtocol?

    var searchItemCalled = false
    var viewDidLoadCalled = false
    var itemSelectedCalled = false
    
    func viewDidLoad(idSite: String) {
        viewDidLoadCalled = true
    }

    func searchItem(item: String) {
        searchItemCalled = true
    }
    
    func itemSelected(idItem: String) {
        itemSelectedCalled = true
    }
}
