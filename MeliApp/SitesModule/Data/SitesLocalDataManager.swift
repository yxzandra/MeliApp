import Foundation

class SitesLocalDataManager: SitesLocalDataManagerInputProtocol {
    var key: String = "Site"
    
    convenience init(key: String) {
        self.init()
        self.key = key
    }
    
    func getSiteSaved() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: key) ?? nil
    }

    func internalSaveSite(idSite: String) {
        let defaults = UserDefaults.standard
        defaults.set(idSite, forKey: key)
    }
}
