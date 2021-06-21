import XCTest
@testable import MeliApp

extension Search {
    static func mocked(fileName: String = "search_200") throws -> Search {
        let json = TestCase().readJSONData(fileName: fileName)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(Search.self, from: json)
        return entity
    }
}

