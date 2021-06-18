import XCTest
@testable import MeliApp

extension Error {
    static func mocked(fileName: String = "sites_404") throws -> Error {
        let json = TestCase().readJSONData(fileName: fileName)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(Error.self, from: json)
        return entity
    }
}

