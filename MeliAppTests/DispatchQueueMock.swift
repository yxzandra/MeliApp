import XCTest
@testable import MeliApp

final class DispatchQueueMock: DispatchQueue {
    func async(execute work: @escaping @convention(block) () -> Void) {
        work()
    }
}
