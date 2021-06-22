import Foundation

class DetailPresenter  {
    
    // MARK: Properties
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorInputProtocol?
    var wireFrame: DetailWireFrameProtocol?

    convenience init(
        view: DetailViewProtocol,
        interactor: DetailInteractorInputProtocol,
        wireFrame: DetailWireFrameProtocol
    ) {
        self.init()
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad(idItem: String) {
        view?.loadActivity()
        view?.hideTableView(isHide: true)
        interactor?.getDetailItem(idItem: idItem)
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func interactorErrorDataPresenter() {
        view?.stopAndHideActivity()
        view?.hideTableView(isHide: false)
        view?.presenterErrorView()
    }
    
    func interactorPushDataPresenter(receivedData: DetailViewModel) {
        view?.stopAndHideActivity()
        view?.hideTableView(isHide: false)
        view?.presenterPushDataView(receivedData: receivedData)
    }
}
