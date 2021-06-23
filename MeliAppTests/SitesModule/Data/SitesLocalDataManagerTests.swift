import XCTest
@testable import MeliApp

class SitesLocalDataManagerTests: XCTestCase {
    let keyUserDefault = "SiteTest"
    let site = "MLA"
    var sut: SitesLocalDataManager!
    var userDefault: UserDefaults!
    
    override func setUp() {
        super.setUp()
        sut = SitesLocalDataManager(key: keyUserDefault)
        userDefault = UserDefaults.standard
    }
    
    override func tearDown() {
        sut = nil
        userDefault.removeObject(forKey: keyUserDefault)
        super.tearDown()
    }
    
    func testInternalSaveSiteSuccess() {
        sut.internalSaveSite(idSite: site)
        let siteSave = userDefault.string(forKey: keyUserDefault)
        
        XCTAssertEqual(site, siteSave)
    }
    
    func testGetSiteSavedSuccess() {
        userDefault.set(site, forKey: keyUserDefault)
        
        let siteSaved = sut.getSiteSaved()
        
        XCTAssertEqual(site, siteSaved)
    }
    
    func testGetSiteSavedNil() {
        let siteSaved = sut.getSiteSaved()
        
        XCTAssertNil(siteSaved)
    }
}
