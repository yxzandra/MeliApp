import Foundation
import UIKit

class SearchWireFrame: SearchWireFrameProtocol {
    class func createSearchModule(with data: String) -> UIViewController {
        let presenter: SearchPresenterProtocol & SearchInteractorOutputProtocol = SearchPresenter()
        
        let viewController = SearchViewController(
            dataSource: SearchDataSource(),
            delegate: SearchDelegate(),
            presenter: presenter
        )

        let interactor: SearchInteractorInputProtocol & SearchRemoteDataManagerOutputProtocol = SearchInteractor()
        let remoteDataManager: SearchRemoteDataManagerInputProtocol = SearchRemoteDataManager()
        let wireFrame: SearchWireFrameProtocol = SearchWireFrame()
        
        viewController.idSite = data
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
    
    func presentViewDetail(from view: SearchViewProtocol, idItem: String) {
        print("SearchWireFrame", idItem)
    }
}
