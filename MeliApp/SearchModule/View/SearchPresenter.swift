import Foundation

class SearchPresenter  {
    // MARK: Properties
    weak var view: SearchViewProtocol?

    var interactor: SearchInteractorInputProtocol?
    var wireFrame: SearchWireFrameProtocol?
    var idSite = String()
    
    convenience init(
        view: SearchViewProtocol,
        interactor: SearchInteractorInputProtocol,
        wireFrame: SearchWireFrameProtocol
    ) {
        self.init()
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    func viewDidLoad(idSite: String) {
        self.idSite = idSite
        view?.hideTableView(isHide: false)
        view?.presenterPushDataView(receivedData: nil)
    }
    
    func searchItem(item: String) {
        view?.loadActivity()
        view?.hideTableView(isHide: true)
        interactor?.searchItem(item: item, idSite: idSite)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func interactorErrorDataPresenter() {
        view?.stopAndHideActivity()
        view?.hideTableView(isHide: false)
        view?.presenterErrorView()
    }
    
    func interactorPushDataPresenter(receivedData: [SearchViewModel]) {
        view?.stopAndHideActivity()
        view?.hideTableView(isHide: false)
        view?.presenterPushDataView(receivedData: receivedData)
    }
}
