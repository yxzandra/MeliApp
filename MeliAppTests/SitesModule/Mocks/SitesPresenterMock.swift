import XCTest
@testable import MeliApp

class SitesPresenterMock: SitesPresenterProtocol {
    var view: SitesViewProtocol?
    var interactor: SitesInteractorInputProtocol?
    var wireFrame: SitesWireFrameProtocol?

    var siteSelectedCalled = false
    var viewDidLoadCalled = false
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func siteSelected(site: SiteViewModel) {
        siteSelectedCalled = true
    }
}
