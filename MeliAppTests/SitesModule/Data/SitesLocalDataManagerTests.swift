import XCTest
@testable import MeliApp

class SitesLocalDataManagerTests: XCTestCase {
    var sut: SitesLocalDataManager!
    
    override func setUp() {
        super.setUp()
        sut = SitesLocalDataManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInternalSaveSiteSuccess() {
        let site = "MLA"
        sut.internalSaveSite(idSite: site)
        let defaults = UserDefaults.standard
        let siteSave = defaults.string(forKey: "Site")
        
        XCTAssertEqual(site, siteSave)
    }
}
