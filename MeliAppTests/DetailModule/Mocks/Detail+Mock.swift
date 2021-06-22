import XCTest
@testable import MeliApp

extension Detail {
    static func mocked(fileName: String = "detail_200") throws -> Detail {
        let json = TestCase().readJSONData(fileName: fileName)
        let decoder = JSONDecoder()
        let entity = try decoder.decode(Detail.self, from: json)
        return entity
    }
}
