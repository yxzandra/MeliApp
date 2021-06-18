import XCTest
@testable import MeliApp

extension Site {
    static func mocked(fileName: String = "sites_200") throws -> [Site] {
        let json = TestCase().readJSONData(fileName: fileName)
        let decoder = JSONDecoder()
        let entity = try decoder.decode([Site].self, from: json)
        return entity
    }
}
