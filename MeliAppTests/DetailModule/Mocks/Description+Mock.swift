import XCTest
@testable import MeliApp

extension Description {
    static func mocked(fileName: String = "description_200") throws -> Description {
        let json = TestCase().readJSONData(fileName: fileName)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(Description.self, from: json)
        return entity
    }
}

