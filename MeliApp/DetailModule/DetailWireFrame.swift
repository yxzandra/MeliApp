import Foundation
import UIKit

class DetailWireFrame: DetailWireFrameProtocol {
    
    class func createDetailModule() -> UIViewController {
        let presenter: DetailPresenterProtocol & DetailInteractorOutputProtocol = DetailPresenter()
        
        let viewController = DetailViewController(
            dataSource: DetailDataSource(),
            delegate: DetailDelegate(),
            presenter: presenter
        )

        let interactor: DetailInteractorInputProtocol & DetailRemoteDataManagerOutputProtocol = DetailInteractor()
        let remoteDataManager: DetailRemoteDataManagerInputProtocol = DetailRemoteDataManager()
        let wireFrame: DetailWireFrameProtocol = DetailWireFrame()

        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
        
    }
}
