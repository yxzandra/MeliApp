import XCTest
@testable import MeliApp

extension SiteViewModel {
    static func mocked() -> [SiteViewModel] {
        let mapper = SiteMapper()
        let model = try! Site.mocked()
        return mapper.reverseMap(values: model)
    }
    
    static func mockedItem() -> SiteViewModel {
        return SiteViewModel(id: "MCO", name: "Colombia")
    }
}
