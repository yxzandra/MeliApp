import XCTest
@testable import MeliApp

extension DetailViewModel {
    static func mocked() -> DetailViewModel {
        let mapper = DetailMapper()
        let model = try! Detail.mocked()
        return mapper.reverseMap(value: model)
    }
}
