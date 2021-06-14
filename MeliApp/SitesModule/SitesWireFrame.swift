import Foundation
import UIKit

class SitesWireFrame: SitesWireFrameProtocol {

    class func createSitesModule() -> UIViewController {
        let navController = UINavigationController(rootViewController: SitesView())
        
        if let view = navController.children.first as? SitesView {
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
}
