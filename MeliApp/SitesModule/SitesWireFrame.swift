import Foundation
import UIKit

class SitesWireFrame: SitesWireFrameProtocol {
    static func createSitesModule() -> UIViewController {
        let navController = UINavigationController(
            rootViewController: SitesViewController(
                dataSource: SitesDataSource(),
                delegate: SitesDelegate(),
                presenter: SitesPresenter()
            )
        )
        
        if let view = navController.children.first as? SitesViewController {
            let presenter: SitesPresenterProtocol & SitesInteractorOutputProtocol = SitesPresenter()
            let interactor: SitesInteractorInputProtocol & SitesRemoteDataManagerOutputProtocol = SitesInteractor()
            let localDataManager: SitesLocalDataManagerInputProtocol = SitesLocalDataManager()
            let remoteDataManager: SitesRemoteDataManagerInputProtocol = SitesRemoteDataManager()
            let wireFrame: SitesWireFrameProtocol = SitesWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }

    func presentViewSearch(from view: SitesViewProtocol, idSide: String) {}
}
