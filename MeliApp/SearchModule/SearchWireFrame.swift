import Foundation
import UIKit

class SearchWireFrame: SearchWireFrameProtocol {

    class func createSearchModule(with data: String) -> UIViewController {
        let viewController = SearchViewController()
        let presenter: SearchPresenterProtocol & SearchInteractorOutputProtocol = SearchPresenter()
        let interactor: SearchInteractorInputProtocol & SearchRemoteDataManagerOutputProtocol = SearchInteractor()
        let localDataManager: SearchLocalDataManagerInputProtocol = SearchLocalDataManager()
        let remoteDataManager: SearchRemoteDataManagerInputProtocol = SearchRemoteDataManager()
        let wireFrame: SearchWireFrameProtocol = SearchWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
}
