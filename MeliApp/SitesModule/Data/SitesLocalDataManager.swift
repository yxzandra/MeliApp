import Foundation

class SitesLocalDataManager: SitesLocalDataManagerInputProtocol {

    func internalSaveSite(idSite: String) {
        let defaults = UserDefaults.standard
        defaults.set(idSite, forKey: "Site")
    }
}
