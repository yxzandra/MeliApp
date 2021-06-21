import XCTest
@testable import MeliApp

extension SearchViewModel {
    static func mocked() -> [SearchViewModel] {
        let mapper = SearchMapper()
        let model = try! Search.mocked()
        return mapper.reverseMap(values: model.results)
    }
    
    static func mockedEmpty() -> [SearchViewModel] {
        let mapper = SearchMapper()
        let model = try! Search.mocked(fileName: "search_empty_200")
        return mapper.reverseMap(values: model.results)
    }
}
