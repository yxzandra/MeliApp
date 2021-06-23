import Mimic
@testable import MeliApp
import XCTest

class TestUtils {}

extension TestCase {
    static let defaultExtension = "json"
    
    func readJSON(fileName: String) -> [String: AnyObject] {
        let data = readJSONData(fileName: fileName)
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
            guard let object = json as? [String: AnyObject] else {
                fatalError("Could not serialize file into Dictionary")
            }
            return object
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func readJSONData(fileName: String) -> Data {
        let testBundle = Bundle(for: type(of: self))
        if let fileURL = testBundle.url(forResource: fileName, withExtension: TestCase.defaultExtension) {
            do {
                let data = try Data(contentsOf: fileURL)
                return data
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("File: \(fileName), not found in Bundle")
        }
    }
}
